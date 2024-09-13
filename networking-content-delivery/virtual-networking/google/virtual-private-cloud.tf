
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie uma VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "Main VPC"
  }
}

# Crie uma sub-rede
resource "aws_subnet" "subnet_public" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public Subnet"
  }
}

# Crie uma tabela de roteamento
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Main Route Table"
  }
}

# Crie uma rota para a Internet
resource "aws_route" "internet_route" {
  route_table_id = aws_route_table.main_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main_internet_gateway.id
}

# Crie um gateway de Internet
resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main.id
}

# Associe a sub-rede à tabela de roteamento
resource "aws_route_table_association" "subnet_association" {
  subnet_id     = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.main_route_table.id
}
    