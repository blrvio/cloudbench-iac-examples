
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud region
  region = "cn-hangzhou"
}

# Create a GraphDB Instance
resource "alicloud_graphdb_instance" "main" {
  # Replace with your GraphDB instance name
  instance_name = "my-graphdb-instance"
  # Replace with your GraphDB instance edition
  edition = "enterprise"
  # Replace with your GraphDB instance version
  version = "2.0"
  # Replace with your GraphDB instance network type
  network_type = "vpc"
  # Replace with your GraphDB instance storage type
  storage_type = "ssd"
  # Replace with your GraphDB instance storage size
  storage_size = 100
  # Replace with your GraphDB instance password
  password = "MyStrongPassword"
  # Replace with your GraphDB instance vpc id
  vpc_id = "vpc-id"
  # Replace with your GraphDB instance vswitch id
  vswitch_id = "vswitch-id"
  # Replace with your GraphDB instance security group id
  security_group_id = "security-group-id"
}

# Create a GraphDB Backup Policy
resource "alicloud_graphdb_backup_policy" "main" {
  # Replace with your GraphDB instance id
  instance_id = alicloud_graphdb_instance.main.id
  # Replace with your GraphDB backup policy name
  backup_policy_name = "my-backup-policy"
  # Replace with your GraphDB backup policy type
  type = "full"
  # Replace with your GraphDB backup policy retention period
  retention_period = 14
}

  