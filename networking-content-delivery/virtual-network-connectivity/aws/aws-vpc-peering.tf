
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um peering de VPC
resource "aws_vpc_peering_connection" "example" {
  accepter_vpc_id = "vpc-xxxxxxxx" # Substitua pelo ID da VPC que irá aceitar o peering
  requester_vpc_id = "vpc-yyyyyyyy" # Substitua pelo ID da VPC que irá solicitar o peering
  auto_accept = true # Aceita automaticamente a solicitação de peering
}

# Ative o peering
resource "aws_vpc_peering_connection_accepter" "example" {
  vpc_peering_connection_id = aws_vpc_peering_connection.example.id
  auto_accept = true # Aceita automaticamente a solicitação de peering
}
    