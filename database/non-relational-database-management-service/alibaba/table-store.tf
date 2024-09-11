
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  # Replace with your Alibaba Cloud access key
  access_key = "your_access_key"
  # Replace with your Alibaba Cloud secret key
  secret_key = "your_secret_key"
  region = "cn-hangzhou"
}

# Create a Table Store instance
resource "alicloud_tablestore_instance" "main" {
  instance_name = "your_table_store_instance"
  # Replace with your desired storage capacity
  capacity_unit = 1
  # Replace with your desired cluster type
  cluster_type = "basic"
  # Replace with your desired instance type
  instance_type = "basic"
}

# Create a Table Store table
resource "alicloud_tablestore_table" "main" {
  instance_name = alicloud_tablestore_instance.main.instance_name
  table_name = "your_table_store_table"
  # Define the primary key structure
  primary_key {
    # Replace with your desired primary key name
    name = "id"
    # Replace with your desired primary key type
    type = "STRING"
  }
}

  