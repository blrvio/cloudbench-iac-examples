
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Transfer Server
resource "aws_transfer_server" "main" {
  # Server Name
  name = "my-transfer-server"
  # Endpoint Type (Public or Private)
  endpoint_type = "PUBLIC"
  # VPC Id (Required for Private Endpoint Type)
  # vpc_id = "your-vpc-id"
  # VPC Subnet IDs (Required for Private Endpoint Type)
  # subnet_ids = ["your-subnet-id1", "your-subnet-id2"]
  # Security Group IDs (Optional)
  # security_group_ids = ["your-security-group-id1", "your-security-group-id2"]
  # Create a user
  user {
    # User name
    server_id = aws_transfer_server.main.id
    user_name = "my-user"
    # Password Policy
    password_policy {
      # Minimum password length
      minimum_password_length = 8
      # Password expiration period (days)
      password_expiration_period = 30
    }
  }
}

# Create a Role for the Server
resource "aws_iam_role" "main" {
  name               = "my-transfer-server-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "transfer.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach the Role to the Server
resource "aws_transfer_server_user" "main" {
  server_id = aws_transfer_server.main.id
  user_name = "my-user"
  role      = aws_iam_role.main.arn
}

  