
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um VPC para o ambiente VMware
resource "aws_vpc" "vmware_vpc" {
  cidr_block = "10.0.0.0/16" # Substitua pelo CIDR desejado

  tags = {
    Name = "VMware VPC"
  }
}

# Crie uma sub-rede para o ambiente VMware
resource "aws_subnet" "vmware_subnet" {
  vpc_id = aws_vpc.vmware_vpc.id
  cidr_block = "10.0.1.0/24" # Substitua pelo CIDR desejado

  tags = {
    Name = "VMware Subnet"
  }
}

# Crie um grupo de segurança para o ambiente VMware
resource "aws_security_group" "vmware_sg" {
  name   = "vmware_sg"
  vpc_id = aws_vpc.vmware_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
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

# Crie uma instância EC2 para o vCenter Server
resource "aws_instance" "vcenter_server" {
  ami           = "ami-xxxxxxxx" # Substitua pela AMI desejada
  instance_type = "t2.micro" # Substitua pelo tipo de instância desejado
  key_name     = "key_name" # Substitua pelo nome da chave SSH
  security_groups = [aws_security_group.vmware_sg.id]
  subnet_id = aws_subnet.vmware_subnet.id

  tags = {
    Name = "vCenter Server"
  }
}
    