
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

# Create a Managed Blockchain Network
resource "aws_managedblockchain_network" "main" {
  name     = "my-blockchain-network"
  framework = "HYPERLEDGER_FABRIC"
  # Configure the network's VPC settings
  vpc_config {
    subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  }
}

# Create a Managed Blockchain Member
resource "aws_managedblockchain_member" "main" {
  network_id = aws_managedblockchain_network.main.id
  member_id   = "my-member"
  # Configure the member's VPC settings
  vpc_config {
    subnet_ids = [aws_subnet.subnet1.id]
  }
}

# Create a Managed Blockchain Node
resource "aws_managedblockchain_node" "main" {
  member_id  = aws_managedblockchain_member.main.member_id
  node_type = "RELAY"
  # Configure the node's VPC settings
  vpc_config {
    subnet_ids = [aws_subnet.subnet2.id]
  }
}

# Create a subnet for the Managed Blockchain Network
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

# Create a second subnet for the Managed Blockchain Network
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

# Create a VPC for the Managed Blockchain Network
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "my-managed-blockchain-vpc"
  }
}

  