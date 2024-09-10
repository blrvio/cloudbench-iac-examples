
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Distro for OpenTelemetry Collector
resource "aws_opentelemetry_collector" "main" {
  name = "my-otel-collector"
  # Configure the collector's configuration
  config = <<EOF
  receivers:
    otlp: {}
    jaeger: {}
  processors:
    batch: {}
  exporters:
    otlp: {
      endpoint: "https://YOUR_OTEL_ENDPOINT"
    }
  service:
    telemetry:
      logs: {}
      metrics: {}
  EOF
}

# Create an IAM role for the collector
resource "aws_iam_role" "main" {
  name               = "otel-collector-role"
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
}

# Attach the IAM role to the collector
resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonOpenTelemetryCollector"
}

# Create a security group for the collector
resource "aws_security_group" "main" {
  name = "otel-collector-sg"
  # Define inbound and outbound rules
  ingress {
    from_port   = 4317
    to_port     = 4317
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

# Create an EC2 instance for the collector
resource "aws_instance" "main" {
  ami           = "ami-08c40ec972c57421d" # AMI of Ubuntu Server 20.04 LTS
  instance_type = "t2.micro"              # Instance type
  # Define the SSH key that will be used to access the instance
  key_name = "my-ssh-key"
  # Define tags for the instance
  tags = {
    Name = "My OTel Collector Instance"
  }

  # Define the network settings of the instance
  # The instance will be created in the default subnet
  vpc_security_group_ids = [aws_security_group.main.id]
  # Assign the IAM role to the instance
  iam_instance_profile = aws_iam_instance_profile.main.id
}

# Create an IAM instance profile for the collector
resource "aws_iam_instance_profile" "main" {
  name = "otel-collector-profile"
  role = aws_iam_role.main.id
}

  