
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um VPN Gateway
resource "aws_vpn_gateway" "main" {
  type = "ipsec.1"
  
  # Substitua pela ID da sua VPC
  vpc_id = "vpc-xxxxxxxx"
}

# Crie um VPN Connection
resource "aws_vpn_connection" "main" {
  vpn_gateway_id = aws_vpn_gateway.main.id
  
  # Substitua pelo endereço IP público da sua VPN
  customer_gateway_ip = "x.x.x.x"
  
  # Substitua pela sua política de VPN
  type = "ipsec.1"

  # Substitua pelos detalhes da sua VPN
  # tunnel_options {
  #   # Substitua pela sua rede local
  #   pre_shared_key = "your_pre_shared_key"
  #   # Substitua pelo algoritmo de criptografia
  #   # ike_versions = ["ikev2"]
  #   # Substitua pelos algoritmos de criptografia
  #   # phase1_algorithms = ["aes-256-cbc", "aes-128-cbc", "aes-192-cbc", "aes-256-gcm", "aes-128-gcm"]
  #   # Substitua pelos algoritmos de criptografia
  #   # phase2_algorithms = ["aes-256-cbc", "aes-128-cbc", "aes-192-cbc", "aes-256-gcm", "aes-128-gcm"]
  #   # Substitua pelos números de port
  #   # ike_port = "500"
  #   # Substitua pelos números de port
  #   # ipsec_port = "4500"
  # }
}

# Crie um VPN Connection Route
resource "aws_vpn_connection_route" "main" {
  vpn_connection_id = aws_vpn_connection.main.id
  
  # Substitua pelo prefixo de rede
  destination_cidr_block = "10.0.0.0/16"
  
  # Substitua pelo ID da sua subnet
  #  target_subnet_id = "subnet-xxxxxxxx"
}

    