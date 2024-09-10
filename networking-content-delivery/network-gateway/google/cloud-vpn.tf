
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud VPN Gateway
resource "google_compute_vpn_gateway" "main" {
  name    = "my-vpn-gateway"
  region  = "us-central1"
  network = "default"
  # Optional: Configure IP address
  # network_interface { ip_address = "10.128.0.1" }
}

# Create a Cloud VPN Tunnel
resource "google_compute_vpn_tunnel" "main" {
  name          = "my-vpn-tunnel"
  region        = "us-central1"
  target_vpn_gateway = google_compute_vpn_gateway.main.id
  # Configure the tunnel endpoint
  peer_gcp_gateway = "projects/your-gcp-project-id/regions/us-central1/vpnGateways/your-gcp-vpn-gateway"
  #[Optional: Configure the tunnel endpoint]
  #peer_instance { ip_address = "10.128.0.2" }
  # Optional: Configure the shared secret
  #shared_secret = "your-shared-secret"
  # Optional: Configure the tunnel routing mode
  #routing_mode = "REGIONAL"
}

  