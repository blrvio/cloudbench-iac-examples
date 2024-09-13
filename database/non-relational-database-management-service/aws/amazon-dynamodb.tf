
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma tabela DynamoDB
resource "aws_dynamodb_table" "users" {
  name           = "users"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "user_id"
  attribute      = {
    user_id = {
      type = "S"
    }
  }
}

# Crie um item na tabela
resource "aws_dynamodb_table_item" "user_1" {
  table_name = aws_dynamodb_table.users.name
  hash_key   = "user_id"
  item       = {
    "user_id"    = "1"
    "username"  = "john.doe"
    "email"     = "john.doe@example.com"
  }
}
    