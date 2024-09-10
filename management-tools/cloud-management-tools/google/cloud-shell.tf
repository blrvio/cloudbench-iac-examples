
    # Configure the Google Cloud Provider
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Shell user
resource "google_compute_instance" "cloud_shell" {
  name = "cloud-shell-user"
  zone = "us-central1-a"

  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "default"
  }
  # Define the metadata for the Cloud Shell user
  metadata = {
    "ssh-keys" = "my-user:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
  }
  # Define the startup script for the Cloud Shell user
  metadata_startup_script = <<EOF
#!/bin/bash
# Install and configure any necessary software
# Configure the Cloud Shell user's environment
EOF
}

  