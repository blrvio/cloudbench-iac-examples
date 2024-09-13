
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_group" "example" {
  availability_zones = ["us-east-1a", "us-east-1b"]
  desired_capacity  = 2
  launch_configuration = aws_launch_configuration.example.id
  max_size          = 5
  min_size          = 1
  vpc_zone_identifier = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelo ID da sua subnet

  # Outras configurações, como tags, cooldown, políticas de escalonamento, etc.
}

resource "aws_launch_configuration" "example" {
  image_id = "ami-xxxxxxxx"
  instance_type = "t2.micro"
  key_name      = "key_name" # Substitua pelo nome da chave SSH
  security_groups = [aws_security_group.example.id]
  # Outras configurações, como usuário, volume, etc.
}

resource "aws_security_group" "example" {
  name   = "allow_ssh"
  vpc_id = "vpc-xxxxxxxx"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

    