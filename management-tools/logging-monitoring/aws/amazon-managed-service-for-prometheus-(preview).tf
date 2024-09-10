
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon Managed Service for Prometheus (AMP) workspace
resource "aws_amp_workspace" "main" {
  name             = "my-amp-workspace"       # Name of your AMP workspace
  alias            = "my-amp-workspace-alias" # Alias for your AMP workspace
  workspace_type   = "PROMETHEUS"             # Workspace type
  retention_period = 86400                    # Retention period in seconds (1 day)
  # Define the alert configuration
  alert_manager_configuration {
    # Configure the alert manager for the workspace
    # Enable the alert manager for the workspace
    enable_alert_manager = true
    # Configure the alert manager configuration
    alert_manager_config {
      # Configure the alert manager cluster
      cluster_config {
        # Configure the alert manager cluster name
        cluster_name = "my-amp-alert-manager-cluster"
        # Configure the alert manager cluster peer discovery settings
        peer_discovery {
          # Configure the alert manager cluster peer discovery type
          type = "STATIC" # Static peer discovery type
          # Configure the alert manager cluster peer discovery list
          static_peers = ["my-amp-alert-manager-cluster-1", "my-amp-alert-manager-cluster-2"]
        }
      }
    }
    # Configure the alert manager routing
    routing_config {
      # Configure the alert manager routing group
      group {
        # Configure the alert manager routing group name
        group_name = "my-amp-alert-manager-group"
        # Configure the alert manager routing group receivers
        receivers = ["my-amp-alert-manager-receiver-1", "my-amp-alert-manager-receiver-2"]
      }
    }
  }
  # Define the logging configuration
  logging_configuration {
    # Configure the logging level for the workspace
    log_level = "INFO" # Logging level
    # Configure the logging destination
    log_destination = "S3" # Logging destination
    # Configure the logging S3 configuration
    s3_config {
      # Configure the logging S3 bucket name
      bucket_name = "my-amp-workspace-logs-bucket" # Logging S3 bucket name
      # Configure the logging S3 prefix
      prefix = "my-amp-workspace-logs" # Logging S3 prefix
    }
  }
}

# Create an IAM role for the AMP workspace
resource "aws_iam_role" "amp_workspace_role" {
  name = "amp-workspace-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "amp.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy" "amp_workspace_policy" {
  name = "amp-workspace-policy"
  role = aws_iam_role.amp_workspace_role.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Action" : [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket",
        "cloudwatch:PutMetricData"
      ],
      "Resource" : "*"
    }]
  })
}

# Create an IAM policy for the AMP workspace
resource "aws_iam_policy" "amp_workspace_policy" {
  name = "amp-workspace-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Action" : [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket",
        "cloudwatch:PutMetricData"
      ],
      "Resource" : "*"
    }]
  })
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "amp_workspace_policy_attachment" {
  role   = aws_iam_role.amp_workspace_role.id
  policy = aws_iam_policy.amp_workspace_policy.arn
}

# Create a security group for the AMP workspace
resource "aws_security_group" "amp_workspace_security_group" {
  name   = "amp-workspace-security-group"
  vpc_id = "vpc-1234567890abcdef0" # Replace with your VPC ID
  # Define the ingress rules for the security group
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Define the egress rules for the security group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance for the AMP workspace
resource "aws_instance" "amp_workspace_instance" {
  ami           = "ami-08c40ec972c57421d" # Replace with the desired AMI
  instance_type = "t2.micro"              # Replace with the desired instance type
  key_name      = "my-key-pair"           # Replace with your key pair name
  # Define the security group for the EC2 instance
  vpc_security_group_ids = [aws_security_group.amp_workspace_security_group.id]
  # Define the IAM role for the EC2 instance
  iam_instance_profile = aws_iam_instance_profile.amp_workspace_instance_profile.id
}

# Create an IAM instance profile for the AMP workspace
resource "aws_iam_instance_profile" "amp_workspace_instance_profile" {
  name = "amp-workspace-instance-profile"
  role = aws_iam_role.amp_workspace_role.name
}

# Create an S3 bucket for the AMP workspace
resource "aws_s3_bucket" "amp_workspace_bucket" {
  bucket = "my-amp-workspace-bucket" # Replace with your desired bucket name
  acl    = "private"                 # Set the bucket ACL to private
  # Define the S3 bucket tags
  tags = {
    Name = "AMP Workspace Bucket"
  }
}

# Create an S3 bucket policy for the AMP workspace
resource "aws_s3_bucket_policy" "amp_workspace_bucket_policy" {
  bucket = aws_s3_bucket.amp_workspace_bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "AWS" : "arn:aws:iam::123456789012:role/amp-workspace-role"
      },
      "Action" : [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource" : [
        "arn:aws:s3:::my-amp-workspace-bucket/*",
        "arn:aws:s3:::my-amp-workspace-bucket"
      ]
    }]
  })
}

  