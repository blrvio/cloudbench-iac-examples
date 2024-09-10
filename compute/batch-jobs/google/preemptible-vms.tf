
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Preemptible VM instance
resource "google_compute_instance" "preemptible" {
  name         = "my-preemptible-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "default"
  }

  # Configure the instance as preemptible
  confidential_instance_config {
    enable_confidential_compute = false
  }
  scheduling {
    automatic_restart  = false
    on_host_maintenance = "MIGRATE"
    preemptible         = true
  }

  tags = ["http-server"]
}

  