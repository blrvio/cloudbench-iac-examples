
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um banco de dados do Glue
resource "aws_glue_database" "example" {
  name = "my_database"
}

# Crie uma tabela do Glue
resource "aws_glue_table" "example" {
  name          = "my_table"
  database_name = aws_glue_database.example.name
  description   = "Example table"

  parameters = {
    "classification" = "my_classification"
  }

  storage_descriptor {
    columns = [
      {
        name = "column1"
        type = "string"
      },
      {
        name = "column2"
        type = "int"
      }
    ]
    location = "s3://my-bucket/data"
    input_format = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    compressed = false
  }
}

# Crie um crawler do Glue
resource "aws_glue_crawler" "example" {
  name = "my_crawler"
  role = "arn:aws:iam::xxxxxxxxxxxx:role/glue-service-role"
  database_name = aws_glue_database.example.name
  schedule        = "cron(0 0 * * ? *)"

  targets {
    s3_targets {
      path = "s3://my-bucket/data"
    }
  }
}
    