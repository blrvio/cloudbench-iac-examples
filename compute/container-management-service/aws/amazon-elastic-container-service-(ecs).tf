
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um cluster ECS
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster"
}

# Crie um serviço ECS
resource "aws_ecs_service" "ecs_service" {
  cluster        = aws_ecs_cluster.ecs_cluster.id
  desired_count = 1
  task_definition = "ecs-task-definition"
  launch_type   = "FARGATE"
  network_configuration {
    awsvpc_configuration {
      subnets  = ["subnet-xxxxxxxx"]
      security_groups = ["sg-xxxxxxxx"]
    }
  }
}

# Crie uma definição de tarefa ECS
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "ecs-task-definition"
  container_definitions = <<EOF
[{"name": "my-container", "image": "nginx:latest", "portMappings": [{"containerPort": 80, "hostPort": 80, "protocol": "tcp"}], "essential": true}]
EOF
}

    