
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um endpoint de serviço para o Amazon S3
resource "aws_privatelink_service_endpoint" "s3_endpoint" {
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_id       = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
  subnet_ids    = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das suas sub-redes

  security_group_ids = [aws_security_group.allow_s3.id] # Substitua pelo ID do grupo de segurança
}

# Crie um grupo de segurança para permitir o acesso ao endpoint de serviço
resource "aws_security_group" "allow_s3" {
  name   = "allow_s3"
  vpc_id = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Substitua pelo CIDR da sua VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
    