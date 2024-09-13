
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um grupo de auto escalonamento
resource "aws_autoscaling_group" "web_server_asg" {
  name                = "web_server_asg"
  vpc_zone_identifier = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes
  min_size             = 1
  max_size             = 3
  desired_capacity      = 1
  launch_configuration = aws_launch_configuration.web_server_lc.name

  # Use o recurso de políticas de escalonamento, se necessário
  # scaling_policy
}

# Crie uma configuração de lançamento
resource "aws_launch_configuration" "web_server_lc" {
  name               = "web_server_lc"
  image_id           = "ami-xxxxxxxx" # Substitua pela AMI desejada
  instance_type       = "t2.micro" # Substitua pelo tipo de instância desejado
  key_name            = "key_name" # Substitua pelo nome da chave SSH
  security_groups     = [aws_security_group.allow_ssh.id]

  user_data = <<EOF
  # Coloque o script de inicialização aqui
  EOF
}

# Crie um grupo de segurança
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
    