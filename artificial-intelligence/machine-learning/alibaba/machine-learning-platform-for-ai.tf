
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"  # Replace with your desired region
}

# Create a Machine Learning Platform for AI Instance
resource "alicloud_paiflow_instance" "main" {
  name          = "my-paiflow-instance"  # The name of your PAIFlow instance
  instance_type = "PAIFlow.Basic.1C2G"   # The type of PAIFlow instance
  # Specify the security group used for the instance
  security_group_ids = [aws_security_group.paiflow_sg.id]
  # Specify the vswitch used for the instance
  vswitch_id = aws_vswitch.paiflow_vswitch.id
}

# Create a Security Group for the PAIFlow instance
resource "alicloud_security_group" "paiflow_sg" {
  name = "paiflow-sg"
  # Allow ingress traffic for PAIFlow management
  ingress {
    from_port   = 80
    to_port     = 80
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

# Create a VSwitch for the PAIFlow instance
resource "alicloud_vswitch" "paiflow_vswitch" {
  name       = "paiflow-vswitch"
  cidr_block = "172.16.0.0/16"  # Replace with your desired CIDR block
  # Specify the virtual private cloud (VPC) to which the VSwitch belongs
  vpc_id = aws_vpc.paiflow_vpc.id
}

# Create a VPC for the PAIFlow instance
resource "alicloud_vpc" "paiflow_vpc" {
  name       = "paiflow-vpc"
  cidr_block = "172.16.0.0/16"  # Replace with your desired CIDR block
}

  