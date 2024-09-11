
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a VPC
resource "alicloud_vpc" "main" {
  name = "my-vpc"
  cidr_block = "172.16.0.0/16"
}

# Create a VSwitch
resource "alicloud_vswitch" "main" {
  vpc_id = alicloud_vpc.main.id
  cidr_block = "172.16.1.0/24"
  zone_id = "cn-hangzhou-a"
  name = "my-vswitch"
}

# Create a security group
resource "alicloud_security_group" "main" {
  name = "my-security-group"
  vpc_id = alicloud_vpc.main.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_ip = "0.0.0.0/0"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_ip = "0.0.0.0/0"
  }
}
  