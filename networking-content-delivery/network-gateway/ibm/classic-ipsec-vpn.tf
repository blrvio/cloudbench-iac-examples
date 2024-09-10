
    # Configure the IBM Cloud provider
provider "ibm" {
  region      = "us-south"
  api_key     = "YOUR_IBM_API_KEY"
  account_id  = "YOUR_IBM_ACCOUNT_ID"
}

# Define the VPN gateway
resource "ibm_is_vpn_gateway" "main" {
  name   = "my-vpn-gateway"
  region = "us-south"
  # Replace with a suitable network
  network_id = "YOUR_NETWORK_ID"
}

# Create an IPsec VPN connection
resource "ibm_is_vpn_connection" "main" {
  name              = "my-vpn-connection"
  gateway_id        = ibm_is_vpn_gateway.main.id
  peer_gateway_ip  = "192.168.1.1"
  peer_gateway_asn  = "100"
  pre_shared_secret = "YOUR_PRE_SHARED_SECRET"
  # Replace with the desired local network to be connected
  local_network = "10.0.0.0/24"
}

  