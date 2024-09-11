
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a virtual private cloud (VPC)
resource "huaweicloud_vpc" "main" {
  name = "my-vpc"
  cidr_block = "192.168.0.0/16"
}

# Create a subnet within the VPC
resource "huaweicloud_subnet" "main" {
  name         = "my-subnet"
  cidr_block   = "192.168.1.0/24"
  vpc_id       = huaweicloud_vpc.main.id
  availability_zone = "cn-north-1a"
}

# Create a security group
resource "huaweicloud_security_group" "main" {
  name = "my-security-group"
  vpc_id = huaweicloud_vpc.main.id
  # Define inbound and outbound rules
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a virtual machine (VM) instance
resource "huaweicloud_server" "main" {
  name         = "my-vm"
  flavor_ref   = "flavor_1"
  image_ref    = "image_1"
  security_group_ids = [huaweicloud_security_group.main.id]
  # Define the subnet for the VM
  subnet_id = huaweicloud_subnet.main.id
}

  