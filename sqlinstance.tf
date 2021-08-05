resource "random_id" "instance_name_suffix" {
  byte_length = 2
}

resource "google_sql_database_instance" "sql_bookshelf" {  
  name   = "sql-bookshelf-${random_id.instance_name_suffix.hex}"
  region = "us-central1"
  deletion_protection = false
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = true
      private_network = google_compute_network.bookshelf_network.id
      authorized_networks {
        name = "public"
        value = "0.0.0.0/0"
      }
    }
  }
  depends_on = [google_compute_network.bookshelf_network]
}
 
resource "google_compute_global_address" "private_ip_address" {
 
  name         = "private-ip-block"
  purpose      = "VPC_PEERING"
  address_type = "INTERNAL"
  ip_version   = "IPV4"
  prefix_length = 20
  network       = google_compute_network.bookshelf_network.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.bookshelf_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

#Create database
resource "google_sql_database" "database" {
  provider = google-beta
  name     = "my-database"
  instance = google_sql_database_instance.sql_bookshelf.name
  depends_on = [google_sql_database_instance.sql_bookshelf]
}

#Create user
resource "google_sql_user" "users" {
  name     = "root"
  instance = google_sql_database_instance.sql_bookshelf.name
  password = "12345"
  depends_on = [google_sql_database.database]
}

