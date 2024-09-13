
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um usuário do WorkDocs
resource "aws_workdocs_user" "user" {
  username = "user_name" # Substitua pelo nome de usuário desejado
  password = "password" # Substitua pela senha desejada
  storage_rule {
    type = "STORAGE_LIMIT"
    limit = 10240
  }
}

# Crie uma pasta compartilhada
resource "aws_workdocs_folder" "shared_folder" {
  name           = "Shared Folder"
  parent_folder_id = aws_workdocs_folder.root_folder.id
  permissions {
    type = "SHARED"
    principals = [aws_workdocs_user.user.id]
  }
}

# Crie uma pasta raiz
resource "aws_workdocs_folder" "root_folder" {
  name = "Root Folder"
}
    