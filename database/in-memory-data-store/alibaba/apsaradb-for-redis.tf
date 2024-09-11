
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region  = "cn-hangzhou" # Replace with your desired region
  profile = "default"  # Replace with your Alibaba Cloud profile
}

# Create an ApsaraDB for Redis instance
resource "alicloud_redis_instance" "example" {
  engine_version        = "5.0"
  instance_class        = "redis.m1.small"
  instance_name        = "example-redis"
  password              = "your-password"
  security_group_id      = "your-security-group-id"
  shard_num             = 1
  vpc_id               = "your-vpc-id"
  vswitch_id            = "your-vswitch-id"
}

# Create a security group
resource "alicloud_security_group" "example" {
  name   = "example-redis-sg"
  vpc_id = "your-vpc-id"
  # Define ingress and egress rules
  ingress {
    from_port   = 6379
    to_port     = 6379
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

  