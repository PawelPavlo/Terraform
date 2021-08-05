resource "google_compute_network" "bookshelf_network" {
  name                    = "bookshelf-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "bookshelf_subnetwork" {
  name          = "bookshelf-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.bookshelf_network.id
}

resource "google_compute_router" "router" {
  name    = "my-router"
  region  = "us-central1"
  network = google_compute_network.bookshelf_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = "my-router"
  region                             = "us-central1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

#Firewall rules
resource "google_compute_firewall" "default" {
  name    = "allow-http-8080"
  network = google_compute_network.bookshelf_network.name
  direction = "INGRESS"
  target_tags = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "icmp"
  }
   allow {
    protocol = "tcp"
    ports    = ["8080", "443", "80"]
  }
  
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-22"
  network = google_compute_network.bookshelf_network.name
  direction = "INGRESS"
  target_tags = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
     allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  
}