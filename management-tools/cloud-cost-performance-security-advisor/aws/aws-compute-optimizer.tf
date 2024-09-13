
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Ative o Compute Optimizer para a sua conta
resource "aws_compute_optimizer_config" "default" {
  auto_mode = true # Habilita o modo automático
  status = "active"  # Ativa o Compute Optimizer
}

# Crie um plano de otimização para EC2
resource "aws_compute_optimizer_recommendation_export_job" "ec2_optimization" {
  name = "ec2-optimization-plan" # Define um nome para o plano de otimização
  compute_optimizer_recommendation_types = ["ec2"] # Especifica o tipo de otimização (neste caso, EC2)
}

# Crie um plano de otimização para Amazon RDS
resource "aws_compute_optimizer_recommendation_export_job" "rds_optimization" {
  name = "rds-optimization-plan" # Define um nome para o plano de otimização
  compute_optimizer_recommendation_types = ["rds"] # Especifica o tipo de otimização (neste caso, RDS)
}

# Crie um plano de otimização para Amazon ECS
resource "aws_compute_optimizer_recommendation_export_job" "ecs_optimization" {
  name = "ecs-optimization-plan" # Define um nome para o plano de otimização
  compute_optimizer_recommendation_types = ["ecs"] # Especifica o tipo de otimização (neste caso, ECS)
}
    