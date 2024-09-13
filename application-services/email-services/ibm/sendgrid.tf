
      # Configure o provedor Sendgrid
provider "sendgrid" {
  api_key = "SG.your_api_key" # Substitua pela sua API key
}

# Crie um template de email
resource "sendgrid_template" "my_template" {
  name = "My Template"
  html_content = "<h1>Olá, {{name}}</h1><p>Este é um email de teste.</p>"
}

# Envie um email
resource "sendgrid_mail" "my_email" {
  from_email = "from@example.com"
  to_email   = "to@example.com"
  subject    = "Assunto do email"
  html       = "<h1>Olá, {{name}}</h1><p>Este é um email de teste.</p>"
  template_id = sendgrid_template.my_template.id
  substitutions = {
    name = "John Doe"
  }
}
    