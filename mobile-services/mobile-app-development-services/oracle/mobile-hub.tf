
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um projeto Mobile Hub
resource "aws_mobilehub_project" "my_project" {
  name = "my-mobile-hub-project"
}

# Crie um backend para o projeto Mobile Hub
resource "aws_mobilehub_backend" "my_backend" {
  project_name = aws_mobilehub_project.my_project.name
  name         = "my-backend"
}

# Crie um aplicativo móvel
resource "aws_mobilehub_app" "my_app" {
  project_name = aws_mobilehub_project.my_project.name
  name         = "my-app"
  backend_name = aws_mobilehub_backend.my_backend.name
}
    