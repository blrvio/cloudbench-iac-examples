
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create an ApsaraDB for RDS SQL Server instance
resource "alicloud_rds_instance" "main" {
  engine         = "SQLServer"
  engine_version = "2019R2Standard"
  instance_type   = "rds.mssql.t1.small"
  instance_name   = "my-sqlserver-instance"
  password       = "your-strong-password"
  storage_type    = "cloud_essd"
  storage_size    = 100
  vswitch_id      = "vsw-id"
  # Replace with your existing vswitch ID
  # Define the security group for the RDS instance
  security_group_ids = [aws_security_group.main.id]
  # Define the tags for the RDS instance
  tags = {
    Name = "My SQL Server Instance"
  }
}

# Create a security group for the RDS instance
resource "alicloud_security_group" "main" {
  name = "sg-rds"
  # Define the ingress rules for the security group
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Define the egress rules for the security group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  