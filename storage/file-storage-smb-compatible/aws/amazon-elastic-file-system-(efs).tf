
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um sistema de arquivos EFS
resource "aws_efs_file_system" "efs" {
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  encrypted        = true
  kms_key_id      = "alias/aws/efs"
  tags = {
    Name = "efs-file-system"
  }
}

# Crie um ponto de montagem EFS
resource "aws_efs_mount_target" "efs_mount" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = "subnet-xxxxxxxx" # Substitua pelo ID da sua subnet
  security_groups = [aws_security_group.allow_ssh.id]
  ip_address      = "172.16.0.100" # Substitua pelo IP do seu servidor
}

# Configure um grupo de segurança para o EFS
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
    