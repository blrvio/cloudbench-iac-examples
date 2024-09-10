
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS CodeDeploy Application
resource "aws_codedeploy_app" "main" {
  name = "my-codedeploy-app" # Name of your CodeDeploy Application
}

# Create an AWS CodeDeploy Deployment Group
resource "aws_codedeploy_deployment_group" "main" {
  app_name         = aws_codedeploy_app.main.name # Name of the CodeDeploy Application
  service_role_arn = aws_iam_role.codedeploy.arn  # ARN of the IAM Role
  # Deploy to all instances in the Auto Scaling Group
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE", "DEPLOYMENT_STOP_ON_REQUEST"]
  }
  deployment_config_name = "CodeDeployDefault.OneAtATime" # Use the default deployment configuration
  # Define the EC2 instances to deploy to
  #  You can specify Auto Scaling Groups, EC2 instances or On-premises instances
  #  Here, we are using an Auto Scaling Group
  #  For more information, see: https://www.terraform.io/docs/providers/aws/r/codedeploy_deployment_group.html#auto_scaling_group_name
  auto_scaling_group_name = "my-autoscaling-group"
  # Add tags to the deployment group
  tags = {
    Name = "My CodeDeploy Deployment Group"
  }
}

# Create an IAM Role for CodeDeploy
resource "aws_iam_role" "codedeploy" {
  name               = "codedeploy-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach permissions to the IAM Role
resource "aws_iam_role_policy" "codedeploy_policy" {
  name   = "codedeploy-policy"
  role   = aws_iam_role.codedeploy.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceAttribute",
        "ec2:DescribeTags",
        "ec2:TerminateInstances"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "autoscaling:UpdateAutoScalingGroup"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Create a deployment configuration
resource "aws_codedeploy_deployment_config" "all_at_once" {
  name = "AllAtOnce"
  minimum_healthy_hosts {
    value = 100
    type  = "PERCENTAGE"
  }
}

# Create a deployment group with a custom deployment configuration
resource "aws_codedeploy_deployment_group" "all_at_once_group" {
  app_name                = aws_codedeploy_app.main.name
  service_role_arn        = aws_iam_role.codedeploy.arn
  deployment_config_name  = aws_codedeploy_deployment_config.all_at_once.name
  auto_scaling_group_name = "my-autoscaling-group"
}

  