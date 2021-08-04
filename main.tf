// Configure the Google Cloud provider
terraform {
  backend "gcs" {
    bucket  = "bookshelf-project-319721-terraform-state"
    prefix  = "terraform/state"
  }
}

provider "google" {
 credentials = file("bookshelf-project-319721-terrakey.json")
 project     = "bookshelf-project-319721"
 region      = "us-central1"
 zone        = "us-central1-a"
}

provider "google-beta" {
  region = "us-central1"
  zone   = "us-central1-a"
}