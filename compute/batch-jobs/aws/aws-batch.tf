
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Batch compute environment
resource "aws_batch_compute_environment" "main" {
  name = "my-batch-compute-environment"
  type = "MANAGED"
  compute_resources {
    # Minimum vCPU and memory resources
    minv_cpus = 2
    memory    = 4096
    # Maximum vCPU and memory resources
    maxv_cpus = 16
    # Set the desired number of instances
    desiredv_cpus = 4
    # Instance types
    instance_types = ["t3.medium"]
  }
  # Configure the service role for the compute environment
  service_role = aws_iam_role.batch_service_role.arn
}

# Create a Batch job queue
resource "aws_batch_job_queue" "main" {
  name                      = "my-batch-job-queue"
  compute_environment_order = [aws_batch_compute_environment.main.arn]
  priority                  = 1000
  # Configure the service role for the job queue
  service_role = aws_iam_role.batch_job_queue_role.arn
}

# Create a Batch job definition
resource "aws_batch_job_definition" "main" {
  name = "my-batch-job-definition"
  type = "container"
  # Container properties
  container_properties {
    image = "ubuntu:latest"
    # Define the command to run
    command = ["echo", "Hello from AWS Batch"]
  }
  # Set the compute environment for the job
  compute_environment = aws_batch_compute_environment.main.arn
  # Set the job queue for the job
  job_queue = aws_batch_job_queue.main.arn
  # Define the timeout in minutes
  timeout {
    attempt_duration_seconds = 600
  }
}

# Create an IAM role for the Batch service
resource "aws_iam_role" "batch_service_role" {
  name               = "batch-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "batch.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Create an IAM role for the Batch job queue
resource "aws_iam_role" "batch_job_queue_role" {
  name               = "batch-job-queue-role"
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

# Attach policies to the Batch service role
resource "aws_iam_role_policy_attachment" "batch_service_role_policy_attachment" {
  role       = aws_iam_role.batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerServiceforEC2Role"
}

# Attach policies to the Batch job queue role
resource "aws_iam_role_policy_attachment" "batch_job_queue_role_policy_attachment" {
  role       = aws_iam_role.batch_job_queue_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerServiceforEC2Role"
}

# Create a Batch job to run the job definition
resource "aws_batch_job" "main" {
  job_definition = aws_batch_job_definition.main.name
  job_queue      = aws_batch_job_queue.main.name
  # Define the parameters for the job
  parameters = {
    "my_parameter" = "value"
  }
}

  