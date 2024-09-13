
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster Fargate
resource "aws_ecs_cluster" "fargate_cluster" {
  name = "fargate-cluster"
}

# Crie uma tarefa Fargate
resource "aws_ecs_task_definition" "fargate_task" {
  family                   = "fargate-task"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = 256
  memory                  = 512
  execution_role_arn      = "arn:aws:iam::xxxxxxxx:role/ecsTaskExecutionRole"

  container {
    name    = "app"
    image   = "amazon/amazon-ecs-sample"
    port_mappings {
      container_port = 80
      host_port      = 80
      protocol       = "tcp"
    }
  }
}

# Crie um serviço Fargate
resource "aws_ecs_service" "fargate_service" {
  cluster        = aws_ecs_cluster.fargate_cluster.id
  desired_count  = 1
  launch_type    = "FARGATE"
  task_definition = aws_ecs_task_definition.fargate_task.arn

  network_configuration {
    awsvpc_configuration {
      subnets = ["subnet-xxxxxxxx"] # Substitua pelos IDs de sua sub-rede
      security_groups  = ["sg-xxxxxxxx"] # Substitua pelos IDs de seus grupos de segurança
      assign_public_ip = true
    }
  }
}
    