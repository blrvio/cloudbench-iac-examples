
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um conexão Express Connect
resource "aws_direct_connect_connection" "example" {
  location     = "us-east-1"
  bandwidth    = "1Gbps"
  name         = "example"
  connection_type = "dedicated"
  # O nome do provedor Express Connect
  provider_name = "xxxxxxxx"
  # O BGP ASN do provedor Express Connect
  provider_asn  = "xxxxxxxx"
  # O número do VLAN do provedor Express Connect
  vlan          = "xxxxxxxx"
}

# Crie uma rota para o gateway Express Connect
resource "aws_route" "example" {
  destination_cidr_block = "0.0.0.0/0"
  # ID da tabela de rota
  route_table_id = "rtb-xxxxxxxx"
  # ID do gateway Express Connect
  gateway_id      = aws_direct_connect_gateway.example.id
}

# Crie um gateway Express Connect
resource "aws_direct_connect_gateway" "example" {
  name = "example"
  # ID da VPC
  amazon_side_asn = "xxxxxxxx"
  # O BGP ASN da VPC
  vpc_id          = "vpc-xxxxxxxx"
}


    