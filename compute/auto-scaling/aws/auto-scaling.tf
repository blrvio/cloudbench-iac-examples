
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um grupo de auto escalonamento
resource "aws_autoscaling_group" "web_server_group" {
  name = "web-server-group"
  min_size = 1
  max_size = 3
  desired_capacity = 2
  health_check_type = "ELB"
  launch_configuration = aws_launch_configuration.web_server.name

  vpc_zone_identifier = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes
  target_group_arns = ["arn:aws:elasticloadbalancing:us-east-1:xxxxxxxx:targetgroup/web-server-target-group/xxxxxxxx"] # Substitua pelo ARN do grupo de destino do ELB

  # Crie uma tag para o grupo de auto escalonamento
  tag {
    key                 = "Name"
    value               = "Web Server Group"
    propagate_at_launch = true
  }
}

# Crie uma configuração de lançamento
resource "aws_launch_configuration" "web_server" {
  name           = "web-server-launch-config"
  image_id       = "ami-xxxxxxxx" # Substitua pela AMI desejada
  instance_type   = "t2.micro" # Substitua pelo tipo de instância desejado
  key_name       = "key_name" # Substitua pelo nome da chave SSH
  security_groups = [aws_security_group.allow_ssh.id] # Substitua pelo ID do grupo de segurança

  # Crie uma tag para a configuração de lançamento
  user_data = "echo 'Hello, world!' > /home/ec2-user/hello.txt"
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
    