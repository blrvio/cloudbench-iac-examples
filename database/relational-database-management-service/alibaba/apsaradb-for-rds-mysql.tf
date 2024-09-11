
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a ApsaraDB for RDS MYSQL instance
resource "alicloud_rds_instance" "main" {
  engine         = "MySQL"
  engine_version = "5.7"
  instance_type  = "rds.mysql.s1.small"
  instance_charge_type = "Postpaid"
  db_name        = "mydatabase"
  db_instance_class = "Basic"
  password       = "MyStrongPassword123"
  security_ips    = ["192.168.1.10/24"]
  # Optional parameters
  availability_zone   = "cn-hangzhou-b"
  instance_network_type = "VPC"
  payment_type      = "PayAsYouGo"
  port               = 3306
  # Configure the VPC and VSwitch
  vpc_id           = "your-vpc-id"
  vswitch_id       = "your-vswitch-id"
  # Set the tags
  tags = {
    Name = "My RDS MYSQL instance"
  }
}

  