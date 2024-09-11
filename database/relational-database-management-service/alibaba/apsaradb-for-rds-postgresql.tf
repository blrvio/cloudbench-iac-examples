
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"
  # Replace with your Alibaba Cloud region
}

# Create an ApsaraDB for RDS PostgreSQL instance
resource "alicloud_rds_instance" "main" {
  # Replace with your desired values
  engine         = "PostgreSQL"
  engine_version = "12.0"
  instance_type   = "rds.pg.t2.small"
  instance_charge_type = "PostPaid"
  db_name        = "my_database"
  db_instance_class = "db.m5.large"
  # ... other relevant configurations
}

# Create a security group for the RDS instance
resource "alicloud_security_group" "main" {
  name = "rds-sg"
  description = "Security group for RDS instance"
  # ... other relevant configurations
}

# Create a rule to allow connections to the RDS instance from your IP
resource "alicloud_security_group_rule" "ingress" {
  type              = "ingress"
  security_group_id = alicloud_security_group.main.id
  # ... other relevant configurations
}

# Associate the security group with the RDS instance
resource "alicloud_rds_instance_attribute" "main" {
  db_instance_id = alicloud_rds_instance.main.id
  security_ips   = [alicloud_security_group.main.id]
}

# Create a user account for the RDS instance
resource "alicloud_rds_account" "main" {
  db_instance_id = alicloud_rds_instance.main.id
  account_name = "my_user"
  account_password = "my_password"
  # ... other relevant configurations
}
  