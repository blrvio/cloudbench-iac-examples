
    # Configure the HuaweiCloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create a GaussDB(for Redis) instance
resource "huaweicloud_gaussdb_for_redis_instance" "main" {
  name     = "my-gaussdb-for-redis-instance"
  engine   = "redis"
  version  = "6.2"
  size     = "small"
  security_group_id = "sg-xxxxxxxx" # Replace with your desired security group ID
  # Optional: you can specify additional settings for the instance, such as the number of shards, password, etc.
  # Refer to the HuaweiCloud documentation for a complete list of options.
}

# Create a security group
resource "huaweicloud_security_group" "main" {
  name = "sg-gaussdb-for-redis"
  description = "Security group for GaussDB(for Redis) instance"
  # Define inbound and outbound rules
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

  