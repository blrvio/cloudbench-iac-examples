
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um ambiente Cloud9
resource "aws_cloud9_environment" "dev_env" {
  name = "dev-env"
  instance_type = "t3.micro"

  # Adicione um usuário ao ambiente
  user {
    name = "admin"
  }

  # Crie uma rede virtual privada (VPC)
  vpc_config {
    subnet_id = "subnet-xxxxxxxx" # Substitua pelo ID da sua subnet
    security_group_ids = ["sg-xxxxxxxx"] # Substitua pelo ID do seu grupo de segurança
  }
}
    