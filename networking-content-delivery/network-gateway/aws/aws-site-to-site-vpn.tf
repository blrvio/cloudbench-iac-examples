
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16" # Specify the VPC CIDR block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "My VPC"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "My Internet Gateway"
  }
}

# Create a Subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24" # Specify the Subnet CIDR block
  availability_zone = "us-east-1a"  # Select an Availability Zone
  tags = {
    Name = "My Subnet"
  }
}

# Create a Customer Gateway
resource "aws_vpn_customer_gateway" "main" {
  bgp_asn    = 65000        # Specify the BGP ASN of the customer network
  ip_address = "172.16.1.1" # Specify the public IP address of the customer gateway
  type       = "ipsec.1"    # Specify the type of VPN connection
  tags = {
    Name = "My Customer Gateway"
  }
}

# Create a Virtual Private Gateway
resource "aws_vpn_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "My VPN Gateway"
  }
}

# Create a VPN Connection
resource "aws_vpn_connection" "main" {
  customer_gateway_id = aws_vpn_customer_gateway.main.id
  vpn_gateway_id      = aws_vpn_gateway.main.id
  type                = "ipsec.1" # Specify the type of VPN connection
  # Specify the VPN connection options
  options {
    # Specify the static routes for the VPN connection
    static_routes_only = false
    # Specify the tunnel configuration options
    tunnel_options {
      # Specify the pre-shared key for the VPN connection
      pre_shared_key = "my-pre-shared-key"
      # Specify the tunnel inside IP addresses
      tunnel_inside_cidr = "10.0.2.0/24"
      # Specify the tunnel outside IP addresses
      tunnel_outside_cidr = "10.0.3.0/24"
    }
  }
  tags = {
    Name = "My VPN Connection"
  }
}

# Create a Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "My Route Table"
  }
}

# Create a Route
resource "aws_route" "main" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0" # Route all traffic to the VPN gateway
  gateway_id             = aws_vpn_gateway.main.id
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}
  