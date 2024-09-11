
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a GaussDB for openGauss instance
resource "huaweicloud_gaussdb_instance" "main" {
  name      = "my-gaussdb-instance" # Name of the GaussDB instance
  engine    = "opengauss" # The database engine to use
  engine_version = "2.0.0" # The database engine version
  instance_type = "GS2.SMALL" # Instance type, such as GS2.SMALL, GS2.MEDIUM, etc.
  # Define the network configuration for the instance
  vpc_id      = "vpc-id"
  subnet_id   = "subnet-id"
  # Optional settings for the GaussDB instance
  # storage_type  = "SSD" # Storage type, such as HDD, SSD, etc.
  # storage_size   = 100 # Storage size in GB
  # backup_policy = "daily" # Backup policy, such as daily, weekly, monthly, etc.
}

# Create a security group for the GaussDB instance
resource "huaweicloud_security_group" "main" {
  name     = "my-gaussdb-security-group"
  vpc_id = "vpc-id"
  # Define ingress and egress rules for the security group
  # ingress {
  #   from_port    = 5432 # PostgreSQL port
  #   to_port      = 5432
  #   protocol = "tcp"
  #   cidr_blocks  = ["0.0.0.0/0"]
  # }
  # egress {
  #   from_port    = 0
  #   to_port      = 0
  #   protocol = "tcp"
  #   cidr_blocks  = ["0.0.0.0/0"]
  # }
}

# Associate the security group to the GaussDB instance
resource "huaweicloud_gaussdb_instance_security_group" "main" {
  instance_id = huaweicloud_gaussdb_instance.main.id
  security_group_id = huaweicloud_security_group.main.id
}

  