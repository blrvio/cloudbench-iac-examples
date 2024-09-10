
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an MWAA Environment
resource "aws_mwaa_environment" "main" {
  name = "my-mwaa-environment" # Name of your MWAA environment
  airflow_version = "2.2.2" # Version of Apache Airflow
  airflow_configuration_options = {
    # Configure Airflow webserver
    "webserver.base_url" = "https://my-mwaa-environment.example.com"
    # Configure Airflow webserver access control
    "webserver.enable_auth" = true
    # Configure Airflow webserver admin password
    "webserver.password" = "MyStrongPassword"
  }
  # Define the environment's networking configuration
  # Note: This uses a default subnet in your selected VPC
  # and requires a default security group
  # You should consider defining your own security groups and subnets
  # for a more secure deployment
  # See the AWS documentation for more details
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment
  network_configuration {
    subnet_id = "subnet-xxxxxxxxxxxxx" # Replace with your subnet ID
    # security_group_id = "sg-xxxxxxxxxxxxx" # Replace with your security group ID
  }
  # Configure logging
  logging_configuration {
    # Configure cloudwatch logs
    # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment#logging_configuration
    cloudwatch_logs_configuration {
      enabled = true
    }
  }
  # Set tags for the MWAA environment
  tags = {
    Name = "My MWAA Environment"
  }
}

# Create an S3 bucket for DAGs
resource "aws_s3_bucket" "dag_bucket" {
  bucket = "my-mwaa-dag-bucket" # Replace with your bucket name
  acl = "private"
  force_destroy = true
}

# Create an IAM role for MWAA
resource "aws_iam_role" "mwaa_role" {
  name = "mwaa-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "Service": "mwaa.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }]
  })
}

# Attach policies to the MWAA role
resource "aws_iam_role_policy" "mwaa_policy" {
  name = "mwaa-policy"
  role = aws_iam_role.mwaa_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::my-mwaa-dag-bucket/*",
          "arn:aws:s3:::my-mwaa-dag-bucket"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        "Resource": [
          "arn:aws:logs:*:*:log-group:/aws/mwaa/*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeInstances",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "secretsmanager:GetSecretValue"
        ],
        "Resource": "arn:aws:secretsmanager:*:*:secret:*"
      }
    ]
  })
}

# Create an IAM policy for DAG access
resource "aws_iam_policy" "dag_access" {
  name = "dag-access-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::my-mwaa-dag-bucket/*",
          "arn:aws:s3:::my-mwaa-dag-bucket"
        ]
      }
    ]
  })
}

# Create an IAM role for DAG access
resource "aws_iam_role" "dag_access_role" {
  name = "dag-access-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "Service": "mwaa.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }]
  })
}

# Attach the DAG access policy to the DAG access role
resource "aws_iam_role_policy_attachment" "dag_access_role_attachment" {
  role = aws_iam_role.dag_access_role.id
  policy_arn = aws_iam_policy.dag_access.arn
}

# Create an S3 bucket policy for DAG access
resource "aws_s3_bucket_policy" "dag_access_policy" {
  bucket = aws_s3_bucket.dag_bucket.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowAccessToMWAA",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${aws_account_id}:role/dag-access-role"
        },
        "Action": [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.dag_bucket.bucket}/*",
          "arn:aws:s3:::${aws_s3_bucket.dag_bucket.bucket}"
        ]
      }
    ]
  })
}

# Configure the MWAA Environment to use the DAG access role
resource "aws_mwaa_environment" "mwaa_environment" {
  name = "my-mwaa-environment"
  airflow_version = "2.2.2"
  airflow_configuration_options = {
    "webserver.base_url" = "https://my-mwaa-environment.example.com",
    "webserver.enable_auth" = true,
    "webserver.password" = "MyStrongPassword"
  }
  network_configuration {
    subnet_id = "subnet-xxxxxxxxxxxxx"
    # security_group_id = "sg-xxxxxxxxxxxxx"
  }
  logging_configuration {
    cloudwatch_logs_configuration {
      enabled = true
    }
  }
  # Configure the DAG access role
  dag_access_role_arn = aws_iam_role.dag_access_role.arn
  # Use the S3 bucket for DAGs
  source_bucket_name = aws_s3_bucket.dag_bucket.bucket
  # Define the environment's networking configuration
  # Note: This uses a default subnet in your selected VPC
  # and requires a default security group
  # You should consider defining your own security groups and subnets
  # for a more secure deployment
  # See the AWS documentation for more details
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment
  tags = {
    Name = "My MWAA Environment"
  }
}

  