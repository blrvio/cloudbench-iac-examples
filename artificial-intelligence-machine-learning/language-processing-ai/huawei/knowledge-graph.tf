
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Knowledge Graph instance
resource "huaweicloud_nlpkg_instance" "main" {
  name = "my-knowledge-graph"
  # Configure the instance details
  instance_type = "basic"
  # Define the storage details
  storage_type = "standard"
  storage_size = 1024
}

# Create a Knowledge Graph schema
resource "huaweicloud_nlpkg_schema" "main" {
  name = "my-schema"
  instance_id = huaweicloud_nlpkg_instance.main.id
  schema = <<EOF
# Define your schema here
EOF
}

# Create a Knowledge Graph dataset
resource "huaweicloud_nlpkg_dataset" "main" {
  name = "my-dataset"
  instance_id = huaweicloud_nlpkg_instance.main.id
  # Define the data source
  data_source = "{your_data_source}"
  # Define the dataset format
  dataset_format = "json"
}

# Create a Knowledge Graph query
resource "huaweicloud_nlpkg_query" "main" {
  name = "my-query"
  instance_id = huaweicloud_nlpkg_instance.main.id
  query = <<EOF
# Define your query here
EOF
}

  