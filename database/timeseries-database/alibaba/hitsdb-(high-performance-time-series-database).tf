
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud region
  region = "cn-hangzhou"
}

# Create a HiTSDB instance
resource "alicloud_hitsdb_instance" "main" {
  # Replace with your desired instance name
  instance_name = "my-hitsdb-instance"
  # Choose an available zone
  zone_id = "cn-hangzhou-a"
  # Select an instance type
  instance_type = "hitsdb.s1.small"
  # Replace with your desired password
  password = "your_password"
}

# (Optional) Create a HiTSDB database
resource "alicloud_hitsdb_database" "main" {
  # Replace with your desired database name
  database_name = "my-hitsdb-database"
  # Connect to the previously created instance
  instance_id = alicloud_hitsdb_instance.main.id
}

# (Optional) Create a HiTSDB table
resource "alicloud_hitsdb_table" "main" {
  # Replace with your desired table name
  table_name = "my-hitsdb-table"
  # Connect to the previously created database
  database_name = alicloud_hitsdb_database.main.database_name
  # Define the table schema
  columns = {
    "timestamp" = "timestamp"
    "value" = "double"
  }
  # (Optional) Set the table TTL
  ttl = 3600
}

  