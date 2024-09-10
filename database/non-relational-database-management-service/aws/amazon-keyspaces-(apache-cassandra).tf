
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Keyspaces table
resource "aws_keyspaces_table" "main" {
  name               = "my-keyspaces-table"
  keyspace_name       = "my-keyspace"
  partition_key       = ["id"] # Define the partition key
  clustering_key      = ["timestamp"] # Define the clustering key
  billing_mode         = "PAY_PER_REQUEST"
  read_capacity_units  = 10
  write_capacity_units = 5

  # Define the table attributes
  attributes {
    name = "id"
    type = "uuid"
  }
  attributes {
    name = "timestamp"
    type = "timestamp"
  }
}

# Create a Keyspaces keyspace
resource "aws_keyspaces_keyspace" "main" {
  name     = "my-keyspace"
  region   = "us-east-1" # Replace with your desired region
  tags = {
    Name = "My Keyspaces Keyspace"
  }
}
  