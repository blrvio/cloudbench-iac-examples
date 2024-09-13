
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um grupo de Auto Scaling
resource "aws_autoscaling_group" "web_server_group" {
  name_prefix  = "web-server-"
  vpc_zone_identifier = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes desejadas
  min_size     = 1
  max_size     = 3
  desired_capacity = 2
  launch_configuration = aws_launch_configuration.web_server_launch_config.id

  # Define a política de escalonamento
  # (Exemplo: escalar automaticamente com base na CPU)
  # (Consulte a documentação do AWS para mais opções de políticas)
  # scaling_policy {
  #   adjustment_type = "PercentChangeInCapacity"
  #   scaling_adjustment = 10
  #   cooldown = 300
  # }
}

# Crie uma configuração de lançamento
resource "aws_launch_configuration" "web_server_launch_config" {
  image_id = "ami-xxxxxxxx" # Substitua pela AMI desejada
  instance_type = "t2.micro" # Substitua pelo tipo de instância desejado
  key_name = "key_name" # Substitua pelo nome da chave SSH
  security_groups = [aws_security_group.allow_ssh.id]

  # Opcional: Adicione tags à instância
  # user_data = ""
}

    