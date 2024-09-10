
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create a Red Hat OpenShift on AWS (ROSA) cluster
resource "aws_rosa_cluster" "main" {
  name = "my-rosa-cluster"  # Name of your ROSA cluster
  # Set the Red Hat OpenShift version
  version = "4.11"
  # Set the desired number of worker nodes
  worker_nodes = 2
  # Define the Kubernetes network configuration
  kubernetes_network_config {
    service_cidr = "10.128.0.0/16"
    pod_cidr = "10.129.0.0/16"
  }
  # Configure the cluster's security settings
  security_group_ids = [aws_security_group.main.id]
}

# Create a security group for the ROSA cluster
resource "aws_security_group" "main" {
  name   = "my-rosa-sg"
  # Define ingress and egress rules for the security group
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

# Create an S3 bucket for storing ROSA cluster data
resource "aws_s3_bucket" "main" {
  bucket = "my-rosa-bucket"  # Name of your S3 bucket
  # Configure the bucket's ACL for access control
  acl    = "private"
}

# Create a KMS key for encrypting ROSA cluster data
resource "aws_kms_key" "main" {
  description = "KMS key for ROSA cluster encryption"
  # Configure the KMS key's deletion protection
  enable_key_rotation = true
}

# Create an IAM role for the ROSA cluster
resource "aws_iam_role" "main" {
  name = "my-rosa-role"
  # Configure the IAM role's permissions
  assume_role_policy = jsonencode({
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
  })
}

# Attach policies to the IAM role
resource "aws_iam_role_policy_attachment" "main" {
  role = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

  