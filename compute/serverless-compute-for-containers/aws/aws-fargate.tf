
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "my-fargate-cluster"
}

# Create a Task Definition
resource "aws_ecs_task_definition" "main" {
  family                   = "my-fargate-task"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = 256
  memory                  = 512
  # Define the container for the task
  container_definitions = <<EOF
[  
  {
    "name": "my-fargate-container",
    "image": "nginx:latest",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "my-fargate-log-group",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "my-fargate-stream"
      }
    }
  }
]
EOF
}

# Create a Service
resource "aws_ecs_service" "main" {
  name            = "my-fargate-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.id
  desired_count  = 1
  # Define the network configuration for the service
  network_configuration {
    awsvpc_configuration {
      # Define the subnets for the service
      subnets = ["subnet-1234567890abcdef0","subnet-0987654321fedcba9"]
      # Define the security groups for the service
      security_groups = [aws_security_group.main.id]
      # Assign a public IP address to the service
      assign_public_ip = true
    }
  }
  # Enable load balancing for the service
  load_balancers {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "my-fargate-container"
    container_port   = 80
  }
}

# Create a Security Group
resource "aws_security_group" "main" {
  name   = "my-fargate-security-group"
  ingress {
    from_port   = 80
    to_port     = 80
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

# Create a Load Balancer Target Group
resource "aws_lb_target_group" "main" {
  name     = "my-fargate-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-1234567890abcdef0" # Replace with your VPC ID
}

  