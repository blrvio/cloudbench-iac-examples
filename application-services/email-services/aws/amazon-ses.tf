
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um domínio SES
resource "aws_ses_domain_identity" "example" {
  domain = "example.com" # Substitua pelo seu domínio
}

# Verifique se o domínio foi verificado
resource "aws_ses_domain_identity_verification" "example" {
  domain = aws_ses_domain_identity.example.domain
}

# Crie um remetente de email
resource "aws_ses_email_identity" "example" {
  email = "example@example.com" # Substitua pelo seu endereço de email
}

# Envie um email
resource "aws_ses_email" "example" {
  from_address = aws_ses_email_identity.example.email
  to_addresses = ["recipient@example.com"] # Substitua pelo endereço de email do destinatário
  subject = "Assunto do email"
  body_html = "<h1>Conteúdo do email</h1>"
}

    