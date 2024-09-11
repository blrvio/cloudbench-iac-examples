
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create a Data Warehouse Instance
resource "huaweicloud_dws_instance" "main" {
  name      = "my-dws-instance" #  Name of your DWS instance
  version   = "2.0" #  DWS version
  engine    = "mysql" #  Database engine
  storage_type = "standard" # Storage type
  # Define the instance size and configuration
  flavor    = "dws.m1.large" #  Instance size
  storage_size = 100 #  Storage size in GB
  # Set the security group
  security_group_ids = [aws_security_group.main.id]
}

# Create a security group
resource "huaweicloud_security_group" "main" {
  name = "sg-dws"
  #  Define the inbound and outbound rules for the security group
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

  