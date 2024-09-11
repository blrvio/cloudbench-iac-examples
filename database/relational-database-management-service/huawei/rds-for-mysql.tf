
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1"
  # Add your Huawei Cloud credentials here
}

# Create a MySQL database
resource "huaweicloud_rds_instance" "main" {
  name            = "my-rds-instance"
  engine         = "MySQL"
  engine_version = "5.7"
  instance_type   = "RDS.MYSQL.c1.small"
  # Set storage capacity
  storage_capacity = 10
  # Specify subnet
  subnet_id       = "subnet-xxxxxxxxxxxxx"
  # Add tags
  tags = {
    Name = "My RDS Instance"
  }
  # Configure security group
  security_group_ids = ["sg-xxxxxxxxxxxxx"]
}

# Create a security group for the database
resource "huaweicloud_security_group" "main" {
  name      = "my-rds-security-group"
  description = "Security group for my RDS instance"
  # Add ingress rule to allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add ingress rule to allow database access
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  