
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1"
}

# Create a VPC
resource "huaweicloud_vpc" "main" {
  name   = "my-vpc"
  cidr_block = "10.0.0.0/16"
}

# Create a subnet
resource "huaweicloud_subnet" "main" {
  name     = "my-subnet"
  vpc_id   = huaweicloud_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

# Create a security group
resource "huaweicloud_security_group" "main" {
  name   = "my-security-group"
  vpc_id = huaweicloud_vpc.main.id

  # Allow inbound SSH traffic
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic to all destinations
  egress {
    protocol = "all"
    from_port = 0
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  