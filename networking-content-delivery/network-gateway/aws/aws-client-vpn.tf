
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Client VPN Endpoint
resource "aws_client_vpn_endpoint" "main" {
  # The name of the Client VPN endpoint
  client_vpn_endpoint_id = "client-vpn-endpoint"
  # The ID of the VPC that the Client VPN endpoint is in
  vpc_id = "vpc-1234567890abcdef0"
  # The DNS servers that will be used for the Client VPN endpoint
  dns_servers = ["192.168.0.1", "192.168.0.2"]
  # The subnet that the Client VPN endpoint is in
  subnet_id = "subnet-1234567890abcdef0"
  # The authentication method for the Client VPN endpoint
  authentication_options {
    # Use Active Directory for authentication
    active_directory {
      # The directory ID
      directory_id = "d-1234567890abcdef0"
      # The server name
      server_name = "ad.example.com"
      # The authentication type
      authentication_type = "ACTIVE_DIRECTORY_FEDERATED_AUTH"
    }
  }
  # The client connection policies for the Client VPN endpoint
  client_connect_options {
    # The VPN protocol for the Client VPN endpoint
    tunnel_options {
      # The VPN protocol
      protocol = "UDP"
    }
  }
  # The connection log options for the Client VPN endpoint
  connection_log_options {
    # Enable connection logging
    enabled = true
    # The S3 bucket to store connection logs
    cloudwatch_log_group_name = "client-vpn-logs"
  }
}

# Create a Client VPN Target Network
resource "aws_client_vpn_target_network" "main" {
  # The ID of the Client VPN endpoint
  client_vpn_endpoint_id = aws_client_vpn_endpoint.main.id
  # The CIDR block of the target network
  target_network_cidr = "10.10.10.0/24"
  # The description of the target network
  description = "Client VPN Target Network"
  # The security groups that the Client VPN endpoint will use
  security_groups = [aws_security_group.main.id]
}

# Create a Security Group for the Client VPN Endpoint
resource "aws_security_group" "main" {
  name        = "client-vpn-sg"
  description = "Security group for Client VPN Endpoint"
  # Allow inbound traffic from the Client VPN endpoint
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.10.0/24"]
  }
  # Allow outbound traffic to the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  