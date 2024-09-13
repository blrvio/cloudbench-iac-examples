
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um balanceador de carga do tipo Application Load Balancer
resource "aws_lb" "my_lb" {
  name            = "my-lb"
  internal        = false
  load_balancer_type = "application"
  subnets         = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes
  security_groups = [aws_security_group.allow_ssh.id]

  # Configure o listener para o balanceador de carga
  listener {
    port        = 80
    protocol    = "HTTP"
    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.my_target_group.arn
    }
  }
}

# Crie um grupo de destino para o balanceador de carga
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
}

# Adicione uma instância EC2 ao grupo de destino
resource "aws_lb_target_group_attachment" "my_target_group_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.web_server.id
  port             = 80
}
    