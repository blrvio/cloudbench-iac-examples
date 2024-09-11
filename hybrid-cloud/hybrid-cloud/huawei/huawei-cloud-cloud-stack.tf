
    # Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a CLOUD Stack Instance
resource "huaweicloud_cloudstack_instance" "main" {
  name = "my-cloudstack-instance"
  image_id = "centos-7.6"
  flavor_id = "c1.xlarge"
  key_pair_name = "my-key-pair"
  # Optionally define security groups
  security_group_ids = [aws_security_group.main.id]
  # Optionally define network information
  network_ids = [aws_network.main.id]
  # Optionally define user data
  user_data = <<EOF
# Your user data script
EOF
}

# Create a Key Pair
resource "huaweicloud_key_pair" "main" {
  name = "my-key-pair"
}

# Create a Security Group
resource "huaweicloud_security_group" "main" {
  name = "my-security-group"
  description = "Security group for CLOUD Stack instances"
  # Optionally define ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Optionally define egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a Network
resource "huaweicloud_network" "main" {
  name = "my-network"
  cidr = "10.0.0.0/16"
}

  