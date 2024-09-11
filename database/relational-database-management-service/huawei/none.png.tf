
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1"
}

# Create a GaussDB for MySQL instance
resource "huaweicloud_gaussdb_mysql_instance" "main" {
  name          = "my-gaussdb-mysql-instance"
  instance_type = "gs.c2.large"
  engine_version = "5.7"
  storage        = 100
  storage_type  = "standard"

  # Add tags to the instance
  tags = {
    Name = "My GaussDB for MySQL Instance"
  }

  # Configure the network settings for the instance
  network {
    subnet_id = "subnet-id"
  }
}

# Create a security group for the instance
resource "huaweicloud_gaussdb_mysql_security_group" "main" {
  name        = "my-gaussdb-mysql-security-group"
  description = "Security group for my GaussDB for MySQL instance"
  vpc_id       = "vpc-id"

  # Add ingress rules for the security group
  ingress {
    cidr_ip = "0.0.0.0/0"
    port = "3306"
    protocol = "tcp"
  }
}

# Attach the security group to the instance
resource "huaweicloud_gaussdb_mysql_instance_security_group" "main" {
  instance_id = huaweicloud_gaussdb_mysql_instance.main.id
  security_group_id = huaweicloud_gaussdb_mysql_security_group.main.id
}

  