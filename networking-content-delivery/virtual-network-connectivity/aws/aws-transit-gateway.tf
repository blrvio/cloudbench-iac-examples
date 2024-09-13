
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Transit Gateway
resource "aws_transit_gateway" "example" {
  description = "Example Transit Gateway"
  tags = {
    Name = "Example Transit Gateway"
  }
}

# Crie uma associação de VPC ao Transit Gateway
resource "aws_transit_gateway_vpc_attachment" "example" {
  transit_gateway_id = aws_transit_gateway.example.id
  vpc_id              = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
  subnet_ids          = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes
}

# Crie uma rota no Transit Gateway
resource "aws_transit_gateway_route" "example" {
  transit_gateway_route_table_id = aws_transit_gateway_route_table.example.id
  destination_cidr_block     = "10.0.0.0/16"
  transit_gateway_attachment_id = aws_transit_gateway_vpc_attachment.example.id
}

# Crie uma tabela de rotas do Transit Gateway
resource "aws_transit_gateway_route_table" "example" {
  transit_gateway_id = aws_transit_gateway.example.id
  tags = {
    Name = "Example Route Table"
  }
}
    