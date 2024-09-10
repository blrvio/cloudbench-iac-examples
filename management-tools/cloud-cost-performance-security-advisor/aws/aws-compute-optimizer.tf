
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Enable Compute Optimizer for your account
resource "aws_compute_optimizer_recommendation" "default" {
  # The resource type for which you want to generate recommendations
  # Possible values are: "ec2", "lambda"
  resource_type = "ec2"
}

# Define the settings for EC2 instance recommendations
resource "aws_compute_optimizer_recommendation_config" "default" {
  # Whether Compute Optimizer should generate recommendations for EC2 instances
  # Possible values are: "true", "false"
  ec2_instance_recommendations = "true"
  # Whether Compute Optimizer should generate recommendations for Auto Scaling groups
  # Possible values are: "true", "false"
  auto_scaling_group_recommendations = "true"
  # Whether Compute Optimizer should generate recommendations for Amazon EBS volumes
  # Possible values are: "true", "false"
  ebs_volume_recommendations = "true"
}

# Define the settings for Lambda function recommendations
resource "aws_compute_optimizer_recommendation_config" "lambda" {
  # Whether Compute Optimizer should generate recommendations for Lambda functions
  # Possible values are: "true", "false"
  lambda_function_recommendations = "true"
}
  