
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um banco de dados do Lake Formation
resource "aws_lakeformation_database" "my_database" {
  name = "my_database"
}

# Crie uma tabela do Lake Formation
resource "aws_lakeformation_table" "my_table" {
  database_name = aws_lakeformation_database.my_database.name
  name          = "my_table"
  table_type    = "EXTERNAL"
  location      = "s3://my-bucket/my-data/" # Substitua pelo local do seu bucket S3
}

# Conceda permissões a um usuário para acessar o banco de dados
resource "aws_lakeformation_permissions" "user_access" {
  data_lake_principal {
    data_lake_principal_identifier = "arn:aws:iam::123456789012:user/my_user" # Substitua pelo ARN do usuário
  }
  resource {
    database_name = aws_lakeformation_database.my_database.name
  }
  permissions = ["SELECT"]
}

# Conceda permissões a um usuário para acessar a tabela
resource "aws_lakeformation_permissions" "user_table_access" {
  data_lake_principal {
    data_lake_principal_identifier = "arn:aws:iam::123456789012:user/my_user" # Substitua pelo ARN do usuário
  }
  resource {
    database_name = aws_lakeformation_database.my_database.name
    table_name    = aws_lakeformation_table.my_table.name
  }
  permissions = ["SELECT"]
}
    