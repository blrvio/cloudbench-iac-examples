
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um conexão Direct Connect
resource "aws_direct_connect_connection" "example" {
  location       = "eqdc2"
  bandwidth      = "1Gbps"
  connection_type = "dedicated"
  name           = "example"
  vlan           = 100
}

# Crie um virtual interface
resource "aws_direct_connect_virtual_interface" "example" {
  connection_id = aws_direct_connect_connection.example.id
  vlan          = 101
  name           = "example"
  address_family = "ipv4"
  mtu            = 1500
}

# Crie uma rota para a virtual interface
resource "aws_route" "example" {
  destination_cidr_block = "10.0.0.0/16"
  gateway_id         = aws_direct_connect_virtual_interface.example.id
}

    