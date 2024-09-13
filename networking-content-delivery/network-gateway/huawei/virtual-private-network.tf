
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # Substitua pelo CIDR desejado

  tags = {
    Name = "VPC Principal"
  }
}

# Crie uma sub-rede
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24" # Substitua pelo CIDR desejado

  tags = {\n    Name = "Sub-rede Pública"
  }
}

# Crie uma gateway de internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Associe a gateway de internet à VPC
resource "aws_vpc_gateway_attachment" "main" {
  vpc_id             = aws_vpc.main.id
  internet_gateway_id = aws_internet_gateway.main.id
}

# Crie uma tabela de rotas
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# Associe a tabela de rotas à sub-rede
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
    