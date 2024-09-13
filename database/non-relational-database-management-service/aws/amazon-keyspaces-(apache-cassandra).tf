
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Keyspace
resource "aws_keyspaces_keyspace" "main" {
  name = "main"
}

# Crie uma tabela
resource "aws_keyspaces_table" "users" {
  keyspace = aws_keyspaces_keyspace.main.name
  name     = "users"

  partition_key {
    name = "user_id"
    type = "uuid"
  }

  clustering_key {
    name = "username"
    type = "text"
  }
}

# Crie um índice
resource "aws_keyspaces_index" "username_index" {
  keyspace   = aws_keyspaces_keyspace.main.name
  table     = aws_keyspaces_table.users.name
  name       = "username_index"
  kind       = "COMPOSITE"
  keys       = ["username"]
  projection  = "KEYS_ONLY"
  storage_mode = "KEYS_ONLY"
}
    