
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um diretório Microsoft Active Directory
resource "aws_directory_service_directory" "example" {
  name = "my-ad-directory"
  password = "password"
  edition = "Standard"
  size = "Small"
  type = "MicrosoftAD"
  vpc_settings {
    vpc_id = "vpc-xxxxxxxx"
    subnet_ids = ["subnet-xxxxxxxx","subnet-xxxxxxxx"]
  }
}

# Crie uma conta de usuário no diretório
resource "aws_directory_service_user" "example" {
  directory_id = aws_directory_service_directory.example.id
  name = "user"
  password = "password"
  username = "user"
  user_type = "NORMAL"
  enabled = true
}

# Adicione o usuário a um grupo
resource "aws_directory_service_group" "example" {
  directory_id = aws_directory_service_directory.example.id
  name = "Administrators"
}

resource "aws_directory_service_group_membership" "example" {
  directory_id = aws_directory_service_directory.example.id
  group_name = aws_directory_service_group.example.name
  user_name = aws_directory_service_user.example.name
}
    