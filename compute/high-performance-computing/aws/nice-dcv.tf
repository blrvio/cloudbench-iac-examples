
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um espaço de trabalho do AppStream 2.0
resource "aws_appstream_fleet" "example" {
  name               = "example"
  compute_capacity    = "standard"
  instance_type      = "stream.standard.small"
  fleet_type         = "ALWAYS_ON"
  disconnect_timeout_in_seconds = 600
  streaming_experience = "DEFAULT"

  image_name        = "Amazon Linux 2023.03.00 (64-bit)"

  # Configure o acesso à rede
  vpc_config {
    subnet_ids = ["subnet-xxxxxxxx"]
    security_group_ids = ["sg-xxxxxxxx"]
  }

  # Configure a senha padrão
  user_settings {
    enable_default_user_experience = true
    user_portal_name = "example"
    default_user_password = "password"
  }
}

# Crie um usuário para o espaço de trabalho
resource "aws_appstream_user" "example" {
  name              = "example"
  first_name        = "John"
  last_name         = "Doe"
  authentication_type = "USER_POOL"

  # Configure a senha padrão
  password = "password"

  # Associe o usuário ao espaço de trabalho
  appstream_user_settings {
    fleet_name = aws_appstream_fleet.example.name
  }
}

    