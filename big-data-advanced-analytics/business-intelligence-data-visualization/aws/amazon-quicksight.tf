
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um usuário do QuickSight
resource "aws_quicksight_user" "admin" {
  email  = "admin@example.com" # Substitua pelo email do usuário
  role   = "ADMIN"
  user_name = "admin"
}

# Crie um grupo do QuickSight
resource "aws_quicksight_group" "example_group" {
  name  = "example_group"
  users = [aws_quicksight_user.admin.user_name]
}

# Crie um conjunto de dados do QuickSight
resource "aws_quicksight_dataset" "example_dataset" {
  name           = "example_dataset"
  data_source_arn = "arn:aws:quicksight:us-east-1:xxxxxxxxxxxx:datasource/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  import_mode  = "SPICE"
  physical_table {
    name     = "example_table"
    data_source_arn = aws_quicksight_datasource.example_datasource.arn
    columns = {
      "column_1" = "string"
      "column_2" = "integer"
    }
  }
}

# Crie uma análise do QuickSight
resource "aws_quicksight_analysis" "example_analysis" {
  name          = "example_analysis"
  analysis_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  arn           = "arn:aws:quicksight:us-east-1:xxxxxxxxxxxx:analysis/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

# Crie um dashboard do QuickSight
resource "aws_quicksight_dashboard" "example_dashboard" {
  name        = "example_dashboard"
  dashboard_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  arn         = "arn:aws:quicksight:us-east-1:xxxxxxxxxxxx:dashboard/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

# Crie uma fonte de dados do QuickSight
resource "aws_quicksight_datasource" "example_datasource" {
  name = "example_datasource"
  type = "S3"
  credentials {
    s3 {
      bucket        = "example_bucket"
      region        = "us-east-1"
      aws_access_key_id     = "AKIAxxxxxxxxxxxxx"
      aws_secret_access_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    }
  }
}

# Crie um usuário do QuickSight
resource "aws_quicksight_user" "user_name" {
  email = "user_name@example.com"
  role   = "READER"
  user_name = "user_name"
}

# Crie uma análise do QuickSight
resource "aws_quicksight_analysis" "analysis_id" {
  name          = "analysis_id"
  analysis_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  arn           = "arn:aws:quicksight:us-east-1:xxxxxxxxxxxx:analysis/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

# Crie um dashboard do QuickSight
resource "aws_quicksight_dashboard" "dashboard_id" {
  name        = "dashboard_id"
  dashboard_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  arn         = "arn:aws:quicksight:us-east-1:xxxxxxxxxxxx:dashboard/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
    