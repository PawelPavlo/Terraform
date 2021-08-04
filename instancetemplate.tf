#Create ServiceAccount
# resource "google_service_account" "service_account_bookshelf" {
#   account_id   = "bookshelf"
#   display_name = "Service Account"
# }
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
  metadata_startup_script = file ("./startup-script.sh")
  service_account {
#    Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "serviceterraform@bookshelf-project-319721.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}
