
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um recurso de tradução
resource "aws_translate_text" "translate_text" {
  source_language_code = "en"
  target_language_code = "pt"
  text = "Hello world"
}

# Exiba o texto traduzido
output "translated_text" {
  value = aws_translate_text.translate_text.translated_text
}
    