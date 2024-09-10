
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id" # Replace with your Google Cloud project ID
  region  = "us-central1"  # Replace with your desired region
}

# Create a sole-tenant node
resource "google_compute_node" "main" {
  name           = "my-sole-tenant-node"
  node_type       = "n1-standard-1"
  maintenance_interval = "AS_NEEDED"
  # Specify the number of local SSD disks
  local_ssd_count = 1
}

# Create a VM instance on the sole-tenant node
resource "google_compute_instance" "main" {
  name         = "my-vm-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
    disk_size_gb = 100
    disk_type    = "pd-standard"
  }
  network_interface {
    network = "default"
  }
  # Specify the node where the VM should be created
  node = google_compute_node.main.name
}

# Create a firewall rule to allow SSH access
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

  