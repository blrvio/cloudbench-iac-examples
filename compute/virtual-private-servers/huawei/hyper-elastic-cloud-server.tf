
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region  = "cn-north-1"
  # Add credentials here
}

# Create a Hyper Elastic Cloud Server
resource "huaweicloud_hecs_server" "main" {
  name       = "my-hecs-server"
  flavor_id  = "ecs.s1.small"
  image_id   = "centos-7.9"
  availability_zone = "cn-north-1a"
  # Add network configuration here
}

# Create a security group for the server
resource "huaweicloud_hecs_security_group" "main" {
  name       = "my-hecs-security-group"
  description = "Security group for my HECS server"
  # Add ingress and egress rules here
}

# Attach the security group to the server
resource "huaweicloud_hecs_security_group_rule" "main" {
  security_group_id = huaweicloud_hecs_security_group.main.id
  # Add security group rule configuration here
}
  