
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a VPC network
resource "google_compute_network" "main" {
  name    = "my-vpc-network"
  auto_create_subnetworks = false
}

# Create a subnet
resource "google_compute_subnetwork" "main" {
  name    = "my-subnet"
  ip_cidr_range = "10.128.0.0/20"
  region = "us-central1"
  network = google_compute_network.main.name
}

# Create a firewall rule
resource "google_compute_firewall" "default" {
  name    = "allow-ssh"
  network = google_compute_network.main.name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# Create an instance
resource "google_compute_instance" "default" {
  name = "my-instance"
  machine_type = "n1-standard-1"
  zone = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
    auto_delete  = true
    disk_size_gb = 100
  }
  network_interface {
    network = google_compute_network.main.name
    subnetwork = google_compute_subnetwork.main.name
  }
  network_performance_config {
    total_egress_bandwidth_tier = "DEFAULT"
  }
  can_ip_forward = false
  metadata {
    "startup-script" = "echo 'Hello from Terraform!' > /home/centos/test.txt"
  }
}

  