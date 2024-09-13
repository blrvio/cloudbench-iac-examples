
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Instance de Amazon Connect
resource "aws_connect_instance" "main" {
  name = "example-connect-instance"
  instance_type = "STANDARD"
}

# Crie um fluxo de contato
resource "aws_connect_contact_flow" "main" {
  instance_id = aws_connect_instance.main.id
  name        = "example-contact-flow"
  content = <<EOF
  # ... (Conteúdo do fluxo de contato)
  EOF
}

# Crie um número de telefone
resource "aws_connect_phone_number" "main" {
  instance_id = aws_connect_instance.main.id
  phone_number = "1234567890"
  type = "toll_free"
}

# Crie um usuário
resource "aws_connect_user" "main" {
  instance_id = aws_connect_instance.main.id
  username = "example-user"
  password = "example-password"
  phone_number = "1234567890"
  security_profile_ids = [aws_connect_security_profile.main.id]
}

# Crie um perfil de segurança
resource "aws_connect_security_profile" "main" {
  instance_id = aws_connect_instance.main.id
  name = "example-security-profile"
  permissions = ["admin"]
}

    