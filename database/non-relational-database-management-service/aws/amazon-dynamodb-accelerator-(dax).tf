
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a DAX Cluster
resource "aws_dax_cluster" "main" {
  name = "my-dax-cluster" # Name of your DAX cluster
  #  Define the number of nodes in the cluster
  node_type = "dax.r4.large"
  #  Define the replication factor for the cluster
  replication_factor = 3
  #  Define the security group for the cluster
  security_group_ids = [aws_security_group.main.id]
  #  Define the subnet group for the cluster
  subnet_group_name = aws_dax_subnet_group.main.name
}

# Create a DAX Subnet Group
resource "aws_dax_subnet_group" "main" {
  name       = "my-dax-subnet-group"
  subnet_ids = ["subnet-1234567890abcdef0", "subnet-1234567890abcdef1"] # Replace with your subnet IDs
}

# Create a Security Group
resource "aws_security_group" "main" {
  name   = "sg-dax"
  # Define the ingress and egress rules
  ingress {
    from_port   = 6379 # DAX port
    to_port     = 6379
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

  