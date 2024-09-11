
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region  = "cn-beijing"
  # Use your Alibaba Cloud access key and secret
  access_key = "your_access_key"
  secret_key = "your_secret_key"
}

# Create an ApsaraDB for MongoDB instance
resource "alicloud_mongodb_instance" "main" {
  # Set the name for your MongoDB instance
  instance_name = "my-mongodb-instance"
  # Choose the MongoDB version
  engine_version = "4.4"
  # Select the instance type
  instance_type = "mongodb.s1.small"
  # Set the connection mode
  connection_mode = "inner"
  # Choose the deployment mode
  deploy_mode = "cluster"
  # Define the number of shards
  shard_count = 1
  # Set the network type
  network_type = "vpc"
  # Choose the security group ID
  security_group_id = aws_security_group.main.id
  # Specify the VPC ID
  vpc_id = "your_vpc_id"
  # Select the VSwitch ID
  vswitch_id = "your_vswitch_id"
  # Optionally, configure the password
  password = "your_password"
  # Specify the storage space (GB)
  storage_space = 100
  # Configure the database name
  database_name = "my_database"
  # Optionally, set the auto-renewal flag
  auto_renew = true
}

# Create a security group
resource "alicloud_security_group" "main" {
  # Set the name for the security group
  name = "my-mongodb-security-group"
  # Configure the ingress rules
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  