
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um VPN gateway
resource "aws_vpn_gateway" "main_vpn_gateway" {
  type = "ipsec.1"
  tags = {
    Name = "Main VPN Gateway"
  }
}

# Crie uma VPN connection
resource "aws_vpn_connection" "main_vpn_connection" {
  vpn_gateway_id = aws_vpn_gateway.main_vpn_gateway.id
  customer_gateway_id = "cgw-xxxxxxxx" # Substitua pelo ID do seu gateway de cliente
  type = "ipsec.1"
  static_routes_only = false
  tags = {
    Name = "Main VPN Connection"
  }
}

# Crie uma VPN route
resource "aws_vpn_connection_route" "main_vpn_connection_route" {
  vpn_connection_id = aws_vpn_connection.main_vpn_connection.id
  destination_cidr_block = "10.0.0.0/16" # Substitua pelo endereço de rede desejado
}

    