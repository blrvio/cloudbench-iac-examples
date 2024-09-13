
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Transit Gateway
resource "aws_transit_gateway" "main" {
  description = "Transit Gateway for connecting VPCs"
  tags = {
    Name = "Transit Gateway"
  }
}

# Crie uma associação de VPC ao Transit Gateway
resource "aws_transit_gateway_vpc_attachment" "attach_vpc" {
  transit_gateway_id = aws_transit_gateway.main.id
  vpc_id             = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
}

# Crie uma rota para o Transit Gateway
resource "aws_transit_gateway_route_table" "main" {
  transit_gateway_id = aws_transit_gateway.main.id
  tags = {
    Name = "Main Route Table"
  }
}

resource "aws_transit_gateway_route" "to_vpc" {
  transit_gateway_route_table_id = aws_transit_gateway_route_table.main.id
  destination_cidr_block       = "10.0.0.0/16" # Substitua pelo CIDR da sua VPC
  transit_gateway_attachment_id = aws_transit_gateway_vpc_attachment.attach_vpc.id
}
    