
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Direct Connect Gateway
resource "aws_direct_connect_gateway" "main" {
  name            = "my-direct-connect-gateway"
  amazon_side_asn = "16509" # ASN on the Amazon side
  # Optional configurations:
  #  bgp_asn = 65000 # ASN on your side
  #  owner_account_id = "123456789012" # Your AWS account ID
  #  propagation_delay = 10 # Propagation delay in seconds
}

# Create a Direct Connect Connection
resource "aws_direct_connect_connection" "main" {
  bandwidth = "1Gbps"     # Bandwidth of the connection
  location  = "us-east-1" # Location of the connection
  name      = "my-direct-connect-connection"
  # Optional configurations:
  #  connection_name = "my-connection"
  #  vlan = 100 # VLAN ID
  #  port_encryption_status = "ENABLED" # Enable encryption
}

# Create a Virtual Interface
resource "aws_direct_connect_virtual_interface" "main" {
  connection_id    = aws_direct_connect_connection.main.id
  name             = "my-virtual-interface"
  owner_account_id = "123456789012" # Your AWS account ID
  vlan             = 100            # VLAN ID
  # Optional configurations:
  #  address_family = "ipv4" # IP address family
  #  amazon_side_asn = "16509" # ASN on the Amazon side
  #  bgp_asn = 65000 # ASN on your side
  #  bgp_auth_key = "my-bgp-auth-key" # BGP authentication key
}

# Create a Direct Connect Virtual Interface to a VPN Gateway
resource "aws_direct_connect_virtual_interface" "vpn" {
  connection_id    = aws_direct_connect_connection.main.id
  name             = "my-vpn-virtual-interface"
  owner_account_id = "123456789012" # Your AWS account ID
  vlan             = 100            # VLAN ID
  # Define the type of virtual interface to be VPN
  vpn_gateway_id = aws_vpn_gateway.main.id
}

# Create a VPN Gateway
resource "aws_vpn_gateway" "main" {
  type = "ipsec.1"
  # Optional configurations:
  #  availability_zone = "us-east-1a"
  #  tags = {
  #    Name = "my-vpn-gateway"
  #  }
}

  