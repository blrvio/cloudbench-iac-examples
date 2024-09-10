
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an RDS instance
resource "aws_db_instance" "main" {
  # Specify the RDS engine to use
  engine = "postgres"

  # Choose the RDS instance class
  instance_class = "db.t3.micro"

  # Set the database name
  db_name = "mydatabase"

  # Specify the database username and password
  username = "admin"
  password = "mypassword"

  # Choose the availability zone
  availability_zone = "us-east-1a"

  # Optionally set the storage options for the database
  storage_type      = "gp2"
  allocated_storage = 10 # Size of the storage volume in GB

  # Set the subnet group
  # You need to create a subnet group first using the resource "aws_db_subnet_group"
  # See the documentation for details: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
  db_subnet_group_name = "my-subnet-group"

  # Set the security group
  # You need to create a security group first using the resource "aws_security_group"
  # See the documentation for details: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
  vpc_security_group_ids = [aws_security_group.main.id]

  # Optionally configure backups for the database
  backup_retention_period = 7    # Keep backups for 7 days
  skip_final_snapshot     = true # Don't take a snapshot before deleting the instance

  # Optionally configure the deletion protection
  deletion_protection = false # Allow deletion of the instance
}

# Create a security group for the RDS instance
resource "aws_security_group" "main" {
  name = "sg-rds"
  # Allow inbound connections to the RDS instance on port 5432 (default Postgres port)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access from anywhere
  }
  # Allow outbound connections from the RDS instance
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access to anywhere
  }
}
  