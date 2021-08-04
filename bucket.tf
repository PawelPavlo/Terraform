#Create bucket
resource "google_storage_bucket" "bookbuck_11222" {
  name          = "bookshelf-project-319721-bucket"
  location      = "US"
  force_destroy = true
}
# Acces bucket
resource "google_storage_default_object_access_control" "public_rule" {
  bucket = google_storage_bucket.bookbuck_11222.name
  role   = "READER"
  entity = "allUsers"
}


