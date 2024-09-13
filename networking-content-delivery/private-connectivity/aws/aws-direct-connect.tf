
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma conexão AWS Direct Connect
resource "aws_direct_connect_connection" "example" {
  location     = "EqDc2"
  bandwidth     = "1Gbps"
  connection_type = "dedicated"
  name          = "example-connection"
}

# Crie uma interface virtual
resource "aws_direct_connect_virtual_interface" "example" {
  connection_id   = aws_direct_connect_connection.example.id
  name           = "example-interface"
  vlan            = 100
  connection_type = "private"
  address_family  = "ipv4"
  mtu             = 1500
}

# Crie um gateway virtual
resource "aws_direct_connect_gateway" "example" {
  name = "example-gateway"
  amazon_side_asn = 64512
  type = "transit"
}

# Crie uma conexão virtual com o gateway virtual
resource "aws_direct_connect_virtual_interface" "example_gateway" {
  connection_id   = aws_direct_connect_connection.example.id
  name           = "example-gateway-interface"
  vlan            = 200
  connection_type = "private"
  address_family  = "ipv4"
  mtu             = 1500
  gateway_id     = aws_direct_connect_gateway.example.id
}

    