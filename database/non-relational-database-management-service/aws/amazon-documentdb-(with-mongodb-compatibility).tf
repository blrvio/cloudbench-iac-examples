
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a DocumentDB cluster
resource "aws_docdb_cluster" "main" {
  cluster_identifier = "my-documentdb-cluster"
  engine             = "mongodb"
  engine_version     = "4.0"
  # Specify the instance size and type
  instance_class = "db.t2.micro"
  # Define the VPC subnet where the cluster will be created
  vpc_security_group_ids = [aws_security_group.main.id]
  # Define the availability zones where the cluster will be deployed
  availability_zones = ["us-east-1a", "us-east-1b"]
  # Configure the master user credentials
  master_username = "admin"
  master_password = "mypassword"
  # Optional: Enable encryption at rest
  #  storage_encrypted    = true
  #  kms_key_id          = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
}

# Create a security group for the DocumentDB cluster
resource "aws_security_group" "main" {
  name = "sg-documentdb"
  # Define ingress rules for the security group
  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"
    # Allow access from your application's security group
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a DocumentDB subnet group
resource "aws_docdb_subnet_group" "main" {
  name       = "my-documentdb-subnet-group"
  subnet_ids = ["subnet-12345678", "subnet-98765432"]
}

# Create a DocumentDB database
resource "aws_docdb_database" "main" {
  db_name     = "my-database"
  cluster_arn = aws_docdb_cluster.main.arn
}

  