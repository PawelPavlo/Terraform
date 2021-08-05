#Instance Template
resource "google_compute_instance_template" "appserver_template" {
  name        = "appserver-template"
  description = "This template is used to create app server instances."

  tags = ["http-server"]
  instance_description = "description assigned to instances"
  machine_type         = "g1-small"
  can_ip_forward       = false
// Create a new boot disk from an image
  disk {
    source_image      = "debian-cloud/debian-9"
    auto_delete       = true
    boot              = true

  }

  network_interface {
    subnetwork = google_compute_subnetwork.bookshelf_subnetwork.id
    access_config {
    }
  }
  
#metadata_startup_script = file ("./startup-script.sh")
#echo "export DB_CONNECTION_STRING=${google_sql_database_instance.sql_bookshelf.connection_name}" >> /etc/environment && \
  
  metadata_startup_script = <<SCRIPT
export DB_CONNECTION_STRING=${google_sql_database_instance.sql_bookshelf.connection_name} && \
export HOME=/root && \
apt-get update && apt-get install -yq ansible git && \
git clone -b master https://github.com/PawelPavlo/Ansible.git /opt/ansible && \
cd /opt/ansible/ansibleproject && ansible-playbook playbook.yml
SCRIPT 

  service_account {
#    Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "serviceterraform@bookshelf-project-319721.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  depends_on = [google_sql_database_instance.sql_bookshelf, google_sql_database.database, google_storage_bucket.bookbuck_11222]
}
