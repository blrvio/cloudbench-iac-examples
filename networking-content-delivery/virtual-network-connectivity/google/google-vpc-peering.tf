
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Specify the region for the VPC peering
}

# Create a Google Compute Engine VPC network
resource "google_compute_network" "main" {
  name    = "vpc-network"
  auto_create_subnetworks = false
}

# Create a Google Compute Engine subnetwork
resource "google_compute_subnetwork" "main" {
  name          = "vpc-subnetwork"
  ip_cidr_range = "10.128.0.0/20"
  region        = "us-central1"
  network       = google_compute_network.main.self_link
}

# Create a second Google Compute Engine VPC network
resource "google_compute_network" "peer" {
  name    = "vpc-network-peer"
  auto_create_subnetworks = false
}

# Create a Google Compute Engine subnetwork for the peer network
resource "google_compute_subnetwork" "peer" {
  name          = "vpc-subnetwork-peer"
  ip_cidr_range = "10.130.0.0/20"
  region        = "us-central1"
  network       = google_compute_network.peer.self_link
}

# Create a Google Compute Engine VPC peering connection
resource "google_compute_network_peering" "main" {
  name           = "vpc-peering"
  network        = google_compute_network.main.self_link
  peer_network = google_compute_network.peer.self_link
  # Optional: Set the export custom routes for the peering connection
  # export_custom_routes = true
  # Optional: Set the import custom routes for the peering connection
  # import_custom_routes = true
}

  