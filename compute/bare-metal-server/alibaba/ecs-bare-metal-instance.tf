
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"  # Replace with your desired region
  # Add your credentials here
  # ...
}

# Create a ECS Bare Metal Instance
resource "alicloud_ecs_bare_metal_instance" "main" {
  # Replace with your desired values
  instance_type = "ebm.n1.xlarge" # Example instance type
  image_id = "centos_7_04_64_20G_alibase_20230102.vhd" # Example image ID
  system_disk_category = "cloud_efficiency" # Example system disk category
  security_group_id = aws_security_group.main.id # Example security group ID
  # Optional tags to apply to the instance
  tags = {
    Name = "My ECS Bare Metal Instance"
  }
}

# Create a Security Group
resource "alicloud_security_group" "main" {
  name = "my-security-group"
  vpc_id = "vpc-id" # Example VPC ID
  # Define ingress and egress rules
  ingress {
    from_port   = 22
    to_port     = 22
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
  