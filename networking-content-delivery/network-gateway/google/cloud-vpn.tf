
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
}

# Crie um túnel VPN
resource "google_compute_vpn_tunnel" "main" {
  name     = "my-vpn-tunnel"
  region   = "us-central1"
  target_vpn_gateway = google_compute_vpn_gateway.main.id
  peer_ip = "10.128.0.2"
  shared_secret = "secret"
}

# Crie um gateway VPN
resource "google_compute_vpn_gateway" "main" {
  name     = "my-vpn-gateway"
  region   = "us-central1"
  network  = google_compute_network.main.id
  interface = "nic0"
  peer_ip = "10.128.0.1"
}

# Crie uma rede VPC
resource "google_compute_network" "main" {
  name    = "my-network"
  auto_create_subnetworks = false
}

# Crie uma rota VPN
resource "google_compute_global_address" "main" {
  name    = "my-vpn-address"
  address_type = "EXTERNAL"
}

resource "google_compute_route" "vpn" {
  name    = "my-vpn-route"
  network = google_compute_network.main.id
  dest_range  = "10.128.0.0/20"
  next_hop_ip = google_compute_global_address.main.address
  priority = 100
}
    