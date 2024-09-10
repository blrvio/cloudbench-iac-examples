
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Transit Gateway
resource "aws_transit_gateway" "main" {
  description = "My Transit Gateway"
  # Enable DNS support for the Transit Gateway
  enable_dns_support = true
  # Enable DNS hostnames for the Transit Gateway
  enable_dns_hostnames = true
  # Tags for the Transit Gateway
  tags = {
    Name = "My Transit Gateway"
  }
}

# Create a Transit Gateway VPC Attachment
resource "aws_transit_gateway_vpc_attachment" "main" {
  transit_gateway_id = aws_transit_gateway.main.id
  vpc_id            = aws_vpc.main.id
  subnet_ids        = [aws_subnet.main.id]
  # Optionally, define the DNS options for the VPC attachment
  dns_options {
    # Enable DNS support for the VPC attachment
    enable_dns_support = true
    # Enable DNS hostnames for the VPC attachment
    enable_dns_hostnames = true
  }
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # Tags for the VPC
  tags = {
    Name = "My VPC"
  }
}

# Create a Subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" # Choose an Availability Zone
  # Tags for the Subnet
  tags = {
    Name = "My Subnet"
  }
}

# Create a Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  # Tags for the Route Table
  tags = {
    Name = "My Route Table"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "main" {
  subnet_id     = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Create a Route for the Transit Gateway
resource "aws_route" "main" {
  route_table_id = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id = aws_transit_gateway.main.id
}

  