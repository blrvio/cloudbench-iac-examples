
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um endpoint do Amazon Translate
resource "aws_translate_endpoint" "my_endpoint" {
  name = "my-endpoint"
  language_code = "en"
}

# Traduza um texto
output "translation" {
  value = aws_translate_translate_text.my_translation.translated_text
}

resource "aws_translate_translate_text" "my_translation" {
  source_language_code = "en"
  target_language_code = "pt"
  text = "Hello, world!"
  endpoint_id = aws_translate_endpoint.my_endpoint.id
}
    