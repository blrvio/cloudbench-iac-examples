
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an App Runner Service
resource "aws_apprunner_service" "main" {
  name = "my-apprunner-service" # Name of your App Runner service
  # Source configuration for the service
  source_configuration {
    # Choose the source location for your application
    # For example, use a Github repository
    # Code repository
    auto_deployments_enabled = true # Enable automatic deployments
    # Define the repository for your application
    repository {
      repository_url = "https://github.com/your-username/your-repo.git" # URL of your GitHub repository
      # Optionally define a branch or commit to deploy
      # branch         = "main" # Branch to deploy
      # commit         = "your-commit-hash" # Commit hash to deploy
      #  A specific commit hash is required if you specify "code_repository" for the source location.
    }
  }
  # Define the service's network configuration
  network_configuration {
    # Define the Egress configuration of the service
    egress {
      # Access type for the service (public or private)
      # Default is public.
      access_type = "PUBLIC"
    }
  }
  # Configure the service's logging configuration
  logging_configuration {
    # Configure logging to CloudWatch Logs
    cloudwatch_logs {
      # Enable or disable CloudWatch Logs
      enabled = true # Default is true
    }
  }
  # Define the service's scaling configuration
  scaling_configuration {
    # Define the minimum and maximum instances for the service
    min_instances = 1
    max_instances = 2
  }
  # Define the service's auto-scaling configuration
  auto_scaling_configuration {
    # Set the target CPU utilization
    target_cpu_utilization_percent = 50
  }
}

# Create an App Runner Connection
# This resource is used to connect your App Runner service to external services
# such as a database.
resource "aws_apprunner_connection" "main" {
  name   = "my-apprunner-connection"
  service = aws_apprunner_service.main.id
  # Define the connection configuration
  connection_config {
    # Choose the type of connection
    # This example uses a VPC connection
    # For more information, see https://docs.aws.amazon.com/apprunner/latest/api/API_CreateConnection.html
    vpc_connection {
      # Specify the name of the VPC connection
      vpc_connection_arn = "arn:aws:ec2:us-east-1:123456789012:vpc-connection/vpc-connection-name"
    }
  }
}

  