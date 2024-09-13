
      # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a security group to allow SSH access
resource "alicloud_security_group" "allow_ssh" {
  name     = "allow_ssh"
  vpc_id   = "vpc-xxxxxxxx" # Replace with your VPC ID
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an ECS instance
resource "alicloud_instance" "web_server" {
  image_id   = "centos_7_04_64_20G_alibase_20211122.vhd" # Replace with your desired AMI
  instance_type = "ecs.n1.small" # Replace with your desired instance type
  security_groups = [alicloud_security_group.allow_ssh.id]
  key_name     = "key_name" # Replace with your SSH key name

  tags = {
    Name = "Web Server"
  }
}

# Create an Elastic IP address
resource "alicloud_eip_address" "web_server_ip" {
  bandwidth = 5
  internet_charge_type = "PayByTraffic"
}

# Associate the Elastic IP address to the ECS instance
resource "alicloud_eip_association" "web_server_association" {
  instance_id = alicloud_instance.web_server.id
  allocation_id = alicloud_eip_address.web_server_ip.allocation_id
}
    