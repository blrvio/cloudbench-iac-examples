
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um diretório de usuário para o WorkSpaces
resource "aws_workspaces_directory" "main" {
  directory_id = "d-xxxxxxxx"
  alias        = "workspaces-dir"
  
  # Opcional: Configure um grupo de segurança para o diretório
  # security_group_ids = ["sg-xxxxxxxx"]
}

# Crie um workspace
resource "aws_workspaces_workspace" "default" {
  bundle_id    = "Standard"
  user_name    = "example-user"
  workspace_id = aws_workspaces_directory.main.id
  
  # Opcional: Configure o nome do workspace
  # name = "Example Workspace"
}

    