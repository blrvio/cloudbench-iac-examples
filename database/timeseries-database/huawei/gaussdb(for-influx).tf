
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a GaussDB(for Influx) instance
resource "huaweicloud_gaussdb_for_influx_instance" "main" {
  name        = "my-gaussdb-influx-instance"
  instance_type = "GaussDB.Influx.Small"
  version      = "1.0"
  # Configure the network settings
  vpc_id      = "vpc-xxxxxxxxxxxxxxxxxxxxxxxx" # Replace with your VPC ID
  subnet_id   = "subnet-xxxxxxxxxxxxxxxxxxxxxxxx" # Replace with your subnet ID
  # Configure the storage settings
  disk_size   = 100
  disk_type   = "SSD"
  # Set the security group for the instance
  security_group_id = "sg-xxxxxxxxxxxxxxxxxxxxxxxx" # Replace with your security group ID
  # Configure the monitoring settings
  monitoring_enabled = true
  # Configure the backup settings
  backup_enabled = true
  # Add tags to the instance
  tags = {
    Name = "My GaussDB(for Influx) Instance"
  }
}

# Create a security group for the GaussDB(for Influx) instance
resource "huaweicloud_vpc_security_group" "main" {
  name   = "sg-gaussdb-influx"
  vpc_id = "vpc-xxxxxxxxxxxxxxxxxxxxxxxx" # Replace with your VPC ID
  # Define the ingress and egress rules
  ingress {
    protocol    = "tcp"
    from_port   = 8086
    to_port     = 8086
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  