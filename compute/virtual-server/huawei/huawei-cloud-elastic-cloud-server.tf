
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west1"
  # Add your credentials here
}

# Create an ECS instance
resource "huaweicloud_ecs_instance" "main" {
  name        = "my-ecs-instance"
  image_id    = "centos-7.6"
  instance_type = "ecs.c2.medium"
  # Configure the network settings
  network_interface {
    subnet_id = "subnet-xxxxxxxx"
    security_group_ids = [aws_security_group.main.id]
  }
  # Attach a security group
  security_groups = [aws_security_group.main.id]
}

# Create a security group
resource "huaweicloud_ecs_security_group" "main" {
  name       = "my-security-group"
  description = "Security group for ECS instance"
  # Add ingress rule for SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add egress rule for all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  