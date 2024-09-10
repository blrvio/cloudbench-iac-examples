
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "my-ecs-cluster"
}

# Create a Task Definition
resource "aws_ecs_task_definition" "main" {
  family                   = "my-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  container_definitions    = <<EOF
[    {
      "name": "my-container",
      "image": "nginx:latest",
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp"
        }
      ]
    }
  ]
EOF
  # Define the task role
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

# Create an IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach an IAM Policy to the ECS Task Execution Role
resource "aws_iam_role_policy" "ecs_task_execution_role_policy" {
  name   = "ecsTaskExecutionRolePolicy"
  role   = aws_iam_role.ecs_task_execution_role.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeVpcs",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeNetworkInterfaces",
        "ecs:CreateTask",
        "ecs:DescribeTasks",
        "ecs:RunTask",
        "ecs:StopTask",
        "ecs:ListTasks",
        "ecs:StartTask",
        "ecs:DescribeClusters"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Create a Security Group for ECS
resource "aws_security_group" "ecs_sg" {
  name   = "ecs-sg"
  vpc_id = "your-vpc-id" # Replace with your VPC ID
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

# Create an ECS Service
resource "aws_ecs_service" "main" {
  cluster         = aws_ecs_cluster.main.id
  name            = "my-ecs-service"
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    awsvpc_configuration {
      subnets          = ["your-subnet-id"] # Replace with your subnet IDs
      security_groups  = [aws_security_group.ecs_sg.id]
      assign_public_ip = true
    }
  }
}

  