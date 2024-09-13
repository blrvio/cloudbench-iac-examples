
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma base de dados
resource "aws_athena_database" "example" {
  name = "my_database"
}

# Crie uma tabela
resource "aws_athena_table" "example" {
  name = "my_table"
  database = aws_athena_database.example.name

  partition_by = ["year", "month"]

  location = "s3://my-bucket/my-prefix"

  columns {
    name = "id"
    type = "int"
  }

  columns {
    name = "name"
    type = "string"
  }

  columns {
    name = "date"
    type = "date"
  }
}

# Execute uma consulta
resource "aws_athena_query" "example" {
  query = "SELECT * FROM my_database.my_table"
  result_configuration {
    output_location = "s3://my-bucket/my-output-prefix"
  }
}
    