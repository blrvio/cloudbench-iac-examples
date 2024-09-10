
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Elemental Server instance
resource "aws_elemental_server" "main" {
  name = "my-elemental-server"
  # Choose an AMI for your Elemental Server instance
  ami = "ami-01234567890abcdef0"
  instance_type = "t3.xlarge"
  # Define the network configuration
  vpc_subnet_id = "subnet-01234567890abcdef0"
  # Define the security group
  security_group_ids = [aws_security_group.main.id]
  # Define the IAM role to be used
  iam_role_arn = "arn:aws:iam::123456789012:role/elemental-server-role"
  # Define the storage configuration
  storage_config {
    # Define the type of storage
    storage_type = "S3"
    # Define the S3 bucket to be used
    s3_bucket_name = "my-elemental-server-bucket"
    # Define the S3 prefix to be used
    s3_prefix = "my-elemental-server-prefix"
  }
  # Define the license configuration
  license_config {
    license_type = "BYOL"
    # Define the license key if BYOL is used
    license_key = "my-license-key"
  }
  # Define the log configuration
  log_config {
    # Define the type of log
    log_type = "CLOUDWATCH"
    # Define the CloudWatch log group to be used
    cloudwatch_log_group_name = "my-elemental-server-log-group"
  }
  # Define the monitoring configuration
  monitoring_config {
    # Define the type of monitoring
    monitoring_type = "CLOUDWATCH"
    # Define the CloudWatch metrics to be collected
    cloudwatch_metrics = ["CPUUtilization", "MemoryUtilization"]
  }
}

# Create a security group
resource "aws_security_group" "main" {
  name   = "sg-elemental-server"
  # Define the ingress and egress rules
  ingress {
    from_port   = 22
    to_port     = 22
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

# Create an IAM role
resource "aws_iam_role" "main" {
  name = "elemental-server-role"
  # Define the assume role policy
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  # Define the policies attached to the role
  inline_policies = {
    "elemental-server-policy" = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*",
        "ec2:*",
        "iam:*",
        "cloudwatch:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  }
}

  