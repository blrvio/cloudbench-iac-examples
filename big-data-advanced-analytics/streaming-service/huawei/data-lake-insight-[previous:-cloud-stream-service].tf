
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create a Data Lake Insight cluster
resource "huaweicloud_dli_cluster" "main" {
  name = "my-dli-cluster" # Name of your Data Lake Insight cluster
  # Specify the cluster's location
  region = "eu-west-1"
  # Configure the cluster's storage configuration
  storage_config {
    # Set storage type to OSS
    storage_type = "OSS"
    # Configure the OSS storage configuration
    oss_storage_config {
      # Specify the OSS endpoint
      oss_endpoint = "oss-eu-central-1.aliyuncs.com"
      # Set the OSS access key ID
      access_key_id = "AKIAXXXXXXXXXXXXXXXX"
      # Set the OSS access key secret
      access_key_secret = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      # Set the OSS bucket name
      bucket = "my-oss-bucket"
    }
  }
  # Set the cluster's compute configuration
  compute_config {
    # Set the instance type
    instance_type = "dli.s1.small"
    # Configure the instance group configuration
    instance_group_config {
      # Set the instance group size
      size = 1
      # Set the instance group type
      type = "MASTER"
    }
  }
}

# Create a Data Lake Insight database
resource "huaweicloud_dli_database" "main" {
  name     = "my-dli-database"
  cluster_id = huaweicloud_dli_cluster.main.id
  # Set the database description
  description = "My Data Lake Insight Database"
}

# Create a Data Lake Insight table
resource "huaweicloud_dli_table" "main" {
  name     = "my-dli-table"
  database_id = huaweicloud_dli_database.main.id
  # Set the table description
  description = "My Data Lake Insight Table"
  # Define the table schema
  schema = <<EOF
CREATE TABLE my_table (
  id INT,
  name STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
EOF
}

  