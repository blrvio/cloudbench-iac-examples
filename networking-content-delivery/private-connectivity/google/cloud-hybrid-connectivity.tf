
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Cloud Interconnect Connection
resource "google_compute_global_address" "interconnect_address" {
  name   = "interconnect-address"
  address_type = "INTERNAL"
  purpose    = "VPC_PEERING"
}

resource "google_compute_global_forwarding_rule" "interconnect_forwarding_rule" {
  name = "interconnect-forwarding-rule"
  ip_protocol = "TCP"
  port_range = "80"
  load_balancing_scheme = "INTERNAL"
  all_ports  = false
  ip_address  = google_compute_global_address.interconnect_address.address
  network_tier = "PREMIUM"
  target     = google_compute_target_instance.interconnect_target_instance.self_link
}

resource "google_compute_target_instance" "interconnect_target_instance" {
  name = "interconnect-target-instance"
  instance = google_compute_instance.interconnect_instance.self_link
}

resource "google_compute_instance" "interconnect_instance" {
  name         = "interconnect-instance"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  network_interface {
    subnetwork = "projects/your-project-id/regions/us-central1/subnetworks/default"
  }
}

# Configure the Cloud Interconnect location
resource "google_compute_interconnect_location" "location" {
  name   = "us-central1-a"
  region = "us-central1"
}

# Configure the Cloud Interconnect service
resource "google_compute_interconnect_service" "service" {
  name     = "my-interconnect-service"
  location = google_compute_interconnect_location.location.name
}

# Configure the Cloud Interconnect attachment
resource "google_compute_interconnect_attachment" "attachment" {
  name     = "my-interconnect-attachment"
  location = google_compute_interconnect_location.location.name
  service   = google_compute_interconnect_service.service.name
  # This is just an example and you'll need to provide the correct value
  # based on your Interconnect provider and connection information.
  provider  = "my-interconnect-provider"
  link      = "my-interconnect-link"
  # This is just an example and you'll need to provide the correct value
  # based on your Interconnect provider and connection information.
  connection = "my-interconnect-connection"
}

# Configure the Cloud Interconnect configuration
resource "google_compute_interconnect_configuration" "config" {
  name     = "my-interconnect-config"
  location = google_compute_interconnect_location.location.name
  # This is just an example and you'll need to provide the correct value
  # based on your Interconnect provider and connection information.
  interconnect_attachment = google_compute_interconnect_attachment.attachment.name
  # This is just an example and you'll need to provide the correct value
  # based on your Interconnect provider and connection information.
  vlan = 100
}

  