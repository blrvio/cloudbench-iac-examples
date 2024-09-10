
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Redshift Cluster
resource "aws_redshift_cluster" "main" {
  cluster_identifier = "my-redshift-cluster"
  # Choose an appropriate node type
  node_type = "dc2.large"
  # Set the number of nodes in the cluster
  number_of_nodes = 1
  # Choose an appropriate database version
  cluster_version = "1.0"
  # Choose an appropriate subnet group
  subnet_group_name = "my-redshift-subnet-group"
  # Set the master user name and password
  master_username      = "admin"
  master_user_password = "password123"
  # Configure the database port
  port = 5439
  # Enable automatic cluster snapshots
  automated_snapshot_retention_period = 1 # Keep snapshots for 1 day
  # Set the preferred maintenance window
  preferred_maintenance_window = "sun:23:00-mon:01:00"
  # Configure the number of days to retain automatic backups
  backup_retention_period = 7 # Keep backups for 7 days
  # Configure encryption at rest
  encrypted = true
  # Define tags for the cluster
  tags = {
    Name = "My Redshift Cluster"
  }
}

# Create a Redshift Security Group
resource "aws_redshift_cluster_security_group" "main" {
  name        = "my-redshift-security-group"
  description = "Security group for my Redshift cluster"
  # Create an ingress rule to allow connections from the specified IP range
  ingress {
    cidr_ip             = "0.0.0.0/0"
    security_group_name = "my-redshift-security-group"
    # Define the port range
    from_port = 5439
    to_port   = 5439
    # Define the protocol
    protocol = "tcp"
  }
}

# Create a Redshift Subnet Group
resource "aws_redshift_subnet_group" "main" {
  name        = "my-redshift-subnet-group"
  description = "Subnet group for my Redshift cluster"
  # Define the subnet IDs to use for the subnet group
  subnet_ids = [aws_subnet.main.id] # Replace with the subnet IDs
}

# Create a subnet
resource "aws_subnet" "main" {
  # Use the existing VPC
  vpc_id     = "vpc-1234567890abcdef0"
  cidr_block = "10.0.1.0/24"
  # Choose an availability zone
  availability_zone = "us-east-1a"
  # Add tags to the subnet
  tags = {
    Name = "My Redshift Subnet"
  }
}

  