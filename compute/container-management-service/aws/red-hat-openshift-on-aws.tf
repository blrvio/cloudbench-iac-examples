
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um VPC para o OpenShift
resource "aws_vpc" "openshift_vpc" {
  cidr_block = "10.0.0.0/16" # Substitua pelo CIDR desejado
  enable_dns_hostnames = true
  enable_dns_support = true
}

# Crie uma sub-rede para o OpenShift
resource "aws_subnet" "openshift_subnet" {
  vpc_id = aws_vpc.openshift_vpc.id
  cidr_block = "10.0.1.0/24" # Substitua pelo CIDR desejado
  availability_zone = "us-east-1a" # Substitua pela zona de disponibilidade desejada
}

# Crie um grupo de segurança para o OpenShift
resource "aws_security_group" "openshift_security_group" {
  name   = "openshift_security_group"
  vpc_id = aws_vpc.openshift_vpc.id

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Crie uma instância EC2 para o OpenShift
resource "aws_instance" "openshift_master" {
  ami           = "ami-xxxxxxxx" # Substitua pela AMI desejada
  instance_type = "t3.xlarge" # Substitua pelo tipo de instância desejado
  key_name     = "key_name" # Substitua pelo nome da chave SSH
  security_groups = [aws_security_group.openshift_security_group.id]
  subnet_id     = aws_subnet.openshift_subnet.id

  tags = {
    Name = "OpenShift Master"
  }
}
    