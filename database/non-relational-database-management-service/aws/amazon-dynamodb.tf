
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a DynamoDB table
resource "aws_dynamodb_table" "main" {
  name           = "my-dynamodb-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"
  }

  # Optional: Define a range key
  # range_key      = "timestamp"
  # attribute {
  #   name = "timestamp"
  #   type = "S"
  # }

  # Optional: Define global secondary indexes
  # global_secondary_index {
  #   index_name = "gs-index"
  #   hash_key    = "id"
  #   range_key    = "timestamp"
  #   projection {
  #     non_key_attributes = ["name", "age"]
  #   }
  # }
}

# Create a DynamoDB table item
resource "aws_dynamodb_item" "main" {
  table_name = aws_dynamodb_table.main.name
  hash_key  = "id"
  item = {
    "id"       = "user1"
    "name"     = "John Doe"
    "age"     = 30
    "timestamp" = "2023-04-21T12:00:00Z"
  }
}

  