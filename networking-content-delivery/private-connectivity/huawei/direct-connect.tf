
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Direct Connect Gateway
resource "aws_direct_connect_gateway" "main" {
  name = "my-direct-connect-gateway" # Name of the gateway
  amazon_side_asn = 64512 # ASN of the AWS side of the connection
  # Define the tags for the gateway
  tags = {
    Name = "My Direct Connect Gateway"
  }
}

# Create a Direct Connect Connection
resource "aws_direct_connect_connection" "main" {
  bandwidth = "1Gbps" # Bandwidth of the connection
  connection_name = "my-direct-connect-connection" # Name of the connection
  # Create a connection using a public virtual interface
  virtual_interface_type = "public"
  # Set the location of the connection
  location = "us-east-1"
  # Set the customer-owned interconnecting device
  customer_owned_ip_address = "1.2.3.4"
  # Set the BGP peering address
  bgp_asn = 65000
  # Set the VLAN to use for the connection
  vlan = 100
  # Associate the connection with a gateway
  direct_connect_gateway_id = aws_direct_connect_gateway.main.id
}

# Create a Virtual Interface
resource "aws_direct_connect_virtual_interface" "main" {
  connection_id = aws_direct_connect_connection.main.id
  name = "my-virtual-interface" # Name of the virtual interface
  # Create a public virtual interface
  virtual_interface_type = "public"
  # Set the VLAN to use for the virtual interface
  vlan = 100
  # Set the address family for the virtual interface
  address_family = "ipv4"
  # Define the tags for the virtual interface
  tags = {
    Name = "My Virtual Interface"
  }
}

  