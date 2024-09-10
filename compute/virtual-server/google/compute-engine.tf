
    # Configure the Google Cloud provider
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Create a Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "my-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    network = "default"
  }
  network_performance_config {
    total_egress_bandwidth_tier = "DEFAULT"
  }
  can_ip_forward = false
  metadata = {
    "startup-script" = "#!/bin/bash\n# Update system\napt update -y && apt upgrade -y\n# Install nginx\napt install nginx -y\n# Start nginx service\nsystemctl start nginx"
  }
}

# Create a firewall rule to allow SSH and HTTP access
resource "google_compute_firewall" "default" {
  name    = "allow-ssh-http"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
  source_ranges = ["0.0.0.0/0"]
}
  