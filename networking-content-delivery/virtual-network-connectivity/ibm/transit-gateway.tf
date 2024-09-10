
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  # Replace with your IBM Cloud API key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Transit Gateway
resource "ibm_transit_gateway" "main" {
  name = "my-transit-gateway"
  # Replace with your VPC ID
  vpc_id = "YOUR_VPC_ID"
}

# Create a Transit Gateway Connection
resource "ibm_transit_gateway_connection" "main" {
  transit_gateway_id = ibm_transit_gateway.main.id
  # Replace with your VPN gateway ID
  vpn_gateway_id = "YOUR_VPN_GATEWAY_ID"
}

  