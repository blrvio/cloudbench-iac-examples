
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Redshift cluster
resource "aws_redshift_cluster" "main" {
  cluster_identifier = "my-redshift-cluster"
  cluster_type      = "dc2.large"
  # Database details
  database_name    = "my-redshift-database"
  master_username  = "admin"
  master_password  = "my-strong-password" # Use a strong password and store it securely
  # Configure the cluster security
  publicly_accessible = false # Make the cluster accessible only from your VPC
  vpc_security_group_ids = [aws_security_group.main.id]
  # Enable automated backups
  automated_snapshot_retention_period = 3 # Keep backups for 3 days
  # Enable logging
  logging {
    bucket_name = "my-s3-bucket"
    s3_key_prefix = "redshift-logs"
  }
}

# Create a security group for the Redshift cluster
resource "aws_security_group" "main" {
  name   = "sg-redshift"
  # Allow inbound connections from your VPC
  ingress {
    from_port   = 5439
    to_port     = 5439
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

# Create a Redshift user
resource "aws_redshift_user" "main" {
  cluster_identifier = aws_redshift_cluster.main.cluster_identifier
  username            = "my-user"
  password            = "my-strong-password" # Use a strong password and store it securely
}

# Create a Redshift database
resource "aws_redshift_database" "main" {
  cluster_identifier = aws_redshift_cluster.main.cluster_identifier
  database_name      = "my-database"
  db_name            = "my-database"
}
  