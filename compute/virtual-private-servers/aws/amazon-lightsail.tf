
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Lightsail instance
resource "aws_lightsail_instance" "main" {
  availability_zone = "us-east-1a" # Choose an availability zone
  blueprint_id      = "amazon-linux-2" # Choose a blueprint (Amazon Linux 2)
  bundle_id         = "nano_1_0" # Choose a bundle (Nano instance)
  name              = "my-lightsail-instance" # Name of the instance
  # Optional settings
  user_data = <<EOF
#!/bin/bash
# Your user data script goes here
EOF
  # Configure the instance's network settings
  # The instance will be created in the default VPC
  # You can configure the subnet and security groups as needed
  # subnet_id = "your-subnet-id"
  # security_group_ids = ["your-security-group-id"]
}

# Create a Lightsail static IP
resource "aws_lightsail_static_ip" "main" {
  name   = "my-static-ip"
  # Optional settings
  # instance_name = "my-lightsail-instance"
}

# Attach the static IP to the instance
resource "aws_lightsail_instance_static_ip" "main" {
  instance_name = aws_lightsail_instance.main.name
  static_ip_name = aws_lightsail_static_ip.main.name
}

# Create a Lightsail disk
resource "aws_lightsail_disk" "main" {
  availability_zone = "us-east-1a" # Choose an availability zone
  disk_name         = "my-lightsail-disk"
  disk_size_gb      = 10 # Size of the disk in GB
  disk_type         = "SSD" # Type of disk
}

# Attach the disk to the instance
resource "aws_lightsail_instance_attach_disk" "main" {
  disk_name     = aws_lightsail_disk.main.disk_name
  instance_name = aws_lightsail_instance.main.name
}

# Create a Lightsail load balancer
resource "aws_lightsail_load_balancer" "main" {
  health_check_config { path = "/" # Configure the health check path
  }
  name              = "my-lightsail-load-balancer"
  # Define the listeners for the load balancer
  listener {
    port     = 80 # Port for HTTP listener
    protocol = "HTTP"
  }
  # Optional settings
  # instance_names = ["my-lightsail-instance"] # List of instances to attach
}

# Create a Lightsail relational database
resource "aws_lightsail_relational_database" "main" {
  availability_zone = "us-east-1a" # Choose an availability zone
  blueprint_id      = "mysql-8.0.23" # Choose a blueprint
  bundle_id         = "db_nano_1" # Choose a bundle
  engine            = "MySQL" # Choose a database engine
  name              = "my-lightsail-database"
  # Define the database credentials
  master_password = "my-database-password"
  master_username = "admin"
  # Optional settings
  # backup_retention_enabled = true # Enable automatic backups
  # backup_retention_period = 30 # Number of days to retain backups
}

  