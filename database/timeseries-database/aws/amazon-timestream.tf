
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um banco de dados do Timestream
resource "aws_timestream_database" "example" {
  database_name = "example"
}

# Crie uma tabela do Timestream
resource "aws_timestream_table" "example" {
  database_name = aws_timestream_database.example.database_name
  table_name    = "example"
  retention_properties {
    memory_store_retention_period_in_hours = 24
  }
}

# Escreva dados na tabela
resource "aws_timestream_write_records" "example" {
  database_name = aws_timestream_database.example.database_name
  table_name    = aws_timestream_table.example.table_name
  records = [
    {
      measure_name = "value"
      measure_value = "10"
      time          = "2023-10-26T12:00:00Z"
      dimensions = {
        "region" = "us-east-1"
      }
    }
  ]
}

# Leia dados da tabela
resource "aws_timestream_query" "example" {
  database_name = aws_timestream_database.example.database_name
  table_name    = aws_timestream_table.example.table_name
  query         = "SELECT * FROM example WHERE time > '2023-10-26T12:00:00Z'"
}

    