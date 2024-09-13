
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um grupo de auto escalonamento
resource "aws_autoscaling_group" "web_server_group" {
  name_prefix  = "web-server-"
  vpc_zone_identifier = ["subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes
  min_size     = 1
  max_size     = 3
  desired_capacity = 1
  launch_configuration = aws_launch_configuration.web_server.name
  health_check_grace_period = 300

  # Use um balanceador de carga clássico para gerenciar o tráfego
  # Para balanceadores de carga de aplicação, use aws_alb_target_group
  target_group_arns = [aws_lb_target_group.web_server.arn]
}

# Crie uma configuração de lançamento para as instâncias EC2
resource "aws_launch_configuration" "web_server" {
  name_prefix  = "web-server-"
  image_id     = "ami-xxxxxxxx" # Substitua pela AMI desejada
  instance_type = "t2.micro" # Substitua pelo tipo de instância desejado
  key_name     = "key_name" # Substitua pelo nome da chave SSH
  security_groups = [aws_security_group.allow_ssh.id]
  # Outros parâmetros podem ser configurados aqui
}

# Crie um balanceador de carga clássico
# Para balanceadores de carga de aplicação, use aws_alb
resource "aws_lb" "web_server" {
  name = "web-server-lb"
  internal = false
  subnets = ["subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes
  security_groups = [aws_security_group.allow_ssh.id]
}

# Crie um grupo de destino para o balanceador de carga
resource "aws_lb_target_group" "web_server" {
  name     = "web-server-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
}

# Crie uma regra de escuta para o balanceador de carga
resource "aws_lb_listener" "web_server" {
  load_balancer_arn = aws_lb.web_server.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_server.arn
  }
}

    