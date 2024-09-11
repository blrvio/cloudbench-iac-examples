
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a SWAS instance
resource "alicloud_swas_instance" "main" {
  name      = "my-swas-instance"
  image_id  = "centos_7_06_x64_20G_alibase_20220810.vhd"
  password   = "MyStrongPassword!" # Replace with a strong password
  system_disk_size_gb = 40
  flavor    = "swas.s1.small"
  vpc_id   = "vpc-bp1j7t32f4r2975d6r"
  vswitch_id = "vsw-bp1j7t32f4r2975d6r"
  security_group_id = aws_security_group.main.id

  # Set the tags for the instance
  tags = {
    Name = "My SWAS Instance"
  }
}

# Create a security group
resource "alicloud_security_group" "main" {
  name   = "sg-swas"
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
  