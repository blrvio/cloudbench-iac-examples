
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1"
  # Replace with your desired region
}

# Create a Redis instance
resource "huaweicloud_dcs_instance" "main" {
  name          = "my-redis-instance"
  # Replace with your desired instance name
  instance_type  = "dcs.c1.small"
  # Replace with your desired instance type
  security_group_ids = ["sg-xxxxxxxx"
  # Replace with your security group ID
  ]
}

# Create a security group for the Redis instance
resource "huaweicloud_vpc_security_group" "main" {
  name   = "sg-redis"
  # Replace with your desired security group name
  # Define ingress rules for the security group
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Output the Redis instance's endpoint
output "redis_endpoint" {
  value = huaweicloud_dcs_instance.main.endpoint
}
  