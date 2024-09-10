
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Persistent Disk
resource "google_compute_disk" "default" {
  name    = "my-persistent-disk"
  zone    = "us-central1-a"
  size_gb = 100
  type    = "pd-standard"
}

# Create a VM instance with attached persistent disk
resource "google_compute_instance" "default" {
  name         = "my-instance"
  zone         = "us-central1-a"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  disk {
    source = google_compute_disk.default.self_link
    auto_delete = true
  }
  network_interface {
    network = "default"
  }
}

  