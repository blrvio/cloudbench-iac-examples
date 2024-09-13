
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma VPN Gateway
resource "aws_vpn_gateway" "vpn_gateway" {
  type = "ipsec.1"
  tags = {
    Name = "VPN Gateway"
  }
}

# Crie uma VPN Connection
resource "aws_vpn_connection" "vpn_connection" {
  vpn_gateway_id  = aws_vpn_gateway.vpn_gateway.id
  customer_gateway_id = "cgw-xxxxxxxx" # Substitua pelo ID do seu gateway de cliente
  type            = "ipsec.1"
  # Configurações de tunelamento VPN
  # ...
  # (Configurações de tunelamento VPN não mostradas)
}

# Crie um Customer Gateway
resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn = 65000 # Substitua pelo ASN do seu gateway de cliente
  ip_address = "10.0.0.1" # Substitua pelo IP público do seu gateway de cliente
  type       = "ipsec.1"
}

# Crie um endpoint VPN para o VPN Gateway
resource "aws_vpn_gateway_route_propagation" "vpn_gateway_route_propagation" {
  vpn_gateway_id = aws_vpn_gateway.vpn_gateway.id
}
    