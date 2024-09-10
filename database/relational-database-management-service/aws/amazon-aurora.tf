
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a security group for Aurora
resource "aws_security_group" "aurora_sg" {
  name = "aurora_sg"
  ingress {
    from_port   = 3306
    to_port     = 3306
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

# Create a parameter group
resource "aws_db_parameter_group" "aurora_parameter_group" {
  name        = "aurora_parameter_group"
  family      = "aurora-mysql-5.7"
  description = "Parameter group for Aurora MySQL 5.7"
  parameters = {
    "character_set_server" = "utf8mb4"
    "character_set_client" = "utf8mb4"
  }
}

# Create an Aurora Cluster
resource "aws_db_cluster" "aurora_cluster" {
  cluster_identifier              = "aurora-cluster"
  engine                          = "aurora-mysql"
  engine_version                  = "5.7.12"
  master_username                 = "admin"
  master_password                 = "password123" # Replace with a strong password
  db_cluster_parameter_group_name = aws_db_parameter_group.aurora_parameter_group.name
  # Define the number of read replicas in the cluster
  # This example creates one read replica.
  replication_source_identifier = "aurora-cluster"
  # Configure the subnet group for the cluster
  subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
  # Define the storage settings for the cluster
  # This example uses 10 GB of storage
  storage_encrypted = true # Enable encryption for the cluster
  storage_type      = "gp2"
  allocated_storage = 10
  # Enable IAM authentication for the cluster
  # You can specify the IAM roles that are allowed to access the cluster.
  # iam_roles = [aws_iam_role.aurora_role.arn]
  # Associate the security group to the cluster
  # This example uses the security group created earlier
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]

  # Optionally, configure the cluster for multi-AZ deployment
  # This example does not use a multi-AZ deployment.
  # enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  # deletion_protection = false # Enable deletion protection
}

# Create a subnet group
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora_subnet_group"
  subnet_ids = ["subnet-12345678", "subnet-98765432"] # Replace with your subnet IDs
  # Optional settings for the subnet group
  # description = "Aurora subnet group"
  # tags = {
  # Name = "Aurora subnet group"
  #}
}

# Create an Aurora DB instance
resource "aws_db_instance" "aurora_db_instance" {
  db_name               = "my_db"
  db_cluster_identifier = aws_db_cluster.aurora_cluster.id
  allocated_storage     = 10
  engine                = "aurora-mysql"
  engine_version        = "5.7.12"
  storage_type          = "gp2"
  # Specify the subnet group for the instance
  # This example uses the subnet group created earlier
  subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
  # Optionally configure the instance for multi-AZ deployment
  # This example does not use a multi-AZ deployment
  # deletion_protection = false
  # auto_minor_version_upgrade = true
}

# Create an IAM role for Aurora
# This is not required for the basic example, but you can use it for advanced scenarios
# resource "aws_iam_role" "aurora_role" {
#  name = "aurora_role"
#  assume_role_policy = <<EOF
# {
#  "Version": "2012-10-17",
#  "Statement": [
#   {
#    "Effect": "Allow",
#    "Principal": {
#     "Service": "rds.amazonaws.com"
#    },
#    "Action": "sts:AssumeRole"
#   }
#  ]
# }
# EOF
#}

# Attach policies to the role
# resource "aws_iam_role_policy_attachment" "aurora_role_policy_attachment" {
#  role = aws_iam_role.aurora_role.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
#}

  