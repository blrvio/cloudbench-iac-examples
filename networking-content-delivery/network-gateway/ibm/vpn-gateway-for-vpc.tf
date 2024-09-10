
    # Configure the IBM Cloud provider
provider "ibm_cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region = "us-south"
}

# Create a VPC
resource "ibm_vpc_network" "main" {
  name = "my-vpc"
  # Optional: Set the resource group for the VPC
  resource_group = "my-resource-group"
}

# Create a VPN gateway
resource "ibm_vpc_vpn_gateway" "main" {
  name = "my-vpn-gateway"
  # The VPC where the VPN gateway will be created
  vpc_id = ibm_vpc_network.main.id
  # Optional: Set the resource group for the VPN gateway
  resource_group = "my-resource-group"
}

# Create a VPN connection
resource "ibm_vpc_vpn_connection" "main" {
  name = "my-vpn-connection"
  # The VPN gateway to which the connection will be created
  vpn_gateway_id = ibm_vpc_vpn_gateway.main.id
  # Optional: Set the resource group for the VPN connection
  resource_group = "my-resource-group"
  # Define the VPN connection properties
  # For example, specify the local IP address range and the remote peer IP address
  local_cidr_block = "10.1.0.0/16"
  peer_cidr_block = "172.16.0.0/16"
}

  