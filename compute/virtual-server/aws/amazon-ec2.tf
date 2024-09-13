
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um grupo de segurança para permitir o acesso SSH
resource "aws_security_group" "allow_ssh" {
  name   = "allow_ssh"
  vpc_id = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC

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

# Crie uma instância EC2
resource "aws_instance" "web_server" {
  ami           = "ami-xxxxxxxx" # Substitua pela AMI desejada
  instance_type = "t2.micro" # Substitua pelo tipo de instância desejado
  key_name     = "key_name" # Substitua pelo nome da chave SSH
  security_groups = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Web Server"
  }
}

# Crie um endereço IP elástico
resource "aws_eip" "web_server_ip" {
  vpc = true
}

# Associe o endereço IP elástico à instância EC2
resource "aws_eip_association" "web_server_association" {
  instance_id = aws_instance.web_server.id
  allocation_id = aws_eip.web_server_ip.id
}
    