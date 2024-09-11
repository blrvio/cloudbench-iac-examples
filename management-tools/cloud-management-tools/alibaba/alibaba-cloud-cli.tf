
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  # Replace with your access key ID
  access_key = "<YOUR_ACCESS_KEY_ID>"
  # Replace with your access key secret
  secret_key = "<YOUR_ACCESS_KEY_SECRET>"
  region = "us-east-1"
}

# Create a security group
resource "alicloud_security_group" "default" {
  name = "my-security-group"
  description = "My security group"
  vpc_id = "<YOUR_VPC_ID>"
  # Define ingress rules
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_ips = ["0.0.0.0/0"]
  }
  # Define egress rules
  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_ips = ["0.0.0.0/0"]
  }
}

# Create an instance
resource "alicloud_instance" "my-instance" {
  # Replace with your AMI ID
  image_id = "<YOUR_AMI_ID>"
  # Choose instance type
  instance_type = "ecs.t2.small"
  security_groups = [alicloud_security_group.default.id]
  # Replace with your VPC ID
  vpc_id = "<YOUR_VPC_ID>"
  # Add tags to the instance
  tags = {
    Name = "my-instance"
  }
}

  