
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um balanceador de carga
resource "aws_lb" "my_load_balancer" {
  name           = "my-load-balancer"
  internal       = false
  load_balancer_type = "application"
  subnets        = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes
  security_groups = [aws_security_group.allow_ssh.id]

  # Opções de configuração do balanceador de carga
  # (Exemplo de configuração para um balanceador de carga HTTP)
  # listener {
  #   port     = 80
  #   protocol = "HTTP"
  #   # Adicione mais configurações do listener, como certificado SSL
  # }
}

# Adicione uma regra de balanceamento de carga
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC

  # Opções de configuração do grupo de destino
  # (Exemplo de configuração para uma instância EC2)
  # health_check {
  #   healthy_threshold   = 2
  #   unhealthy_threshold = 2
  #   timeout             = 5
  #   interval            = 10
  #   # Adicione mais configurações de verificação de integridade
  # }
}

# Associe o balanceador de carga ao grupo de destino
resource "aws_lb_listener_rule" "my_listener_rule" {
  listener_arn = aws_lb.my_load_balancer.arn
  priority      = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }

  condition {
    # Defina condições para a regra de balanceamento de carga
  }
}
    