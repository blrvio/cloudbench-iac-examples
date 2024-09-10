
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Cloud Console instance
resource "google_compute_instance" "main" {
  name         = "my-cloud-console-instance"
  zone         = "us-central1-a"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    network = "default"
  }
}

# Create a Cloud Console firewall
resource "google_compute_firewall" "main" {
  name    = "my-cloud-console-firewall"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# Create a Cloud Console bucket
resource "google_storage_bucket" "main" {
  name = "my-cloud-console-bucket"
  location = "US"
  force_destroy = true
}

  