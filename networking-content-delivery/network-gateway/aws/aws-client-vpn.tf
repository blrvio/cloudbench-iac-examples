
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma VPN Endpoint
resource "aws_client_vpn_endpoint" "example" {
  # ...
  server_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
  # ...
}

# Crie um Network Association
resource "aws_client_vpn_network_association" "example" {
  # ...
  client_vpn_endpoint_id = aws_client_vpn_endpoint.example.id
  # ...
}

# Crie um Route
resource "aws_client_vpn_route" "example" {
  # ...
  client_vpn_endpoint_id = aws_client_vpn_endpoint.example.id
  # ...
}
    