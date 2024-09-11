
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
  # Add your access key ID and secret key
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}

# Create a Security Group
resource "alicloud_security_group" "default" {
  name   = "ecs-sg"
  vpc_id = "vpc-your-vpc-id" # Replace with your VPC ID
  # Add inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an ECS Instance
resource "alicloud_ecs_instance" "main" {
  # Choose your desired image
  image_id = "centos_7_04_64_20G_alibase_20200320.vhd"
  # Select the instance type
  instance_type = "ecs.n1.small"
  security_groups = [alicloud_security_group.default.id]
  # Specify the availability zone
  availability_zone = "cn-hangzhou-a"
  system_disk {
    size = 100
    # Choose the disk type
    category = "cloud_efficiency"
  }
  # Set the instance name
  instance_name = "my-ecs-instance"
  # Add tags to the instance
  tags = {
    Name = "My ECS Instance"
  }
}

  