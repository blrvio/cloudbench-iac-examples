
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um aplicativo AppStream 2.0
resource "aws_appstream_application" "app" {
  name = "my-app"
  description = "My App Stream 2.0 application"
  # ... outras configurações do aplicativo
}

# Crie um stack de aplicativos AppStream 2.0
resource "aws_appstream_stack" "stack" {
  name = "my-stack"
  description = "My App Stream 2.0 stack"
  # ... outras configurações do stack
}

# Crie um usuário AppStream 2.0
resource "aws_appstream_user" "user" {
  name = "my-user"
  username = "my-username"
  # ... outras configurações do usuário
}
    