
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  # Configure the region and credentials
  region = "region_name" # Replace with your region
  # ... other provider settings
}

# Create a PostgreSQL instance
resource "huaweicloud_rds_instance" "main" {
  # Basic settings
  name = "my-postgres-instance"
  # Choose PostgreSQL version
  engine_version = "13.0"
  # Choose instance type
  instance_type = "rds.gp1.small"
  # Choose storage type and size
  storage_type = "SSD"
  storage_size = 100
  # Configure network
  vpc_id = "vpc-id"
  subnet_id = "subnet-id"
  # Security group configuration
  security_group_id = "sg-id"
  # Configure password
  password = "your_password"
  # ... other settings
}

# Create a security group (optional)
resource "huaweicloud_vpc_security_group" "main" {
  name = "my-rds-security-group"
  description = "Allow access to the PostgreSQL instance"
  # ... other settings
}

# Create a subnet (optional)
resource "huaweicloud_vpc_subnet" "main" {
  name = "my-rds-subnet"
  cidr_block = "10.0.0.0/24"
  # ... other settings
}

  