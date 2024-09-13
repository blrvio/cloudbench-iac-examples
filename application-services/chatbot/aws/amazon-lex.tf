
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um bot do Amazon Lex
resource "aws_lex_bot" "my_bot" {
  name     = "MyBot"
  locale   = "en-US"
  child_directed = false
  intent_names = ["GreetingIntent"] # Substitua pelo nome do seu intent
  role_arn = "arn:aws:iam::123456789012:role/lex-bot-role" # Substitua pelo ARN do seu papel do IAM
  # ...
}

# Crie um intent do Amazon Lex
resource "aws_lex_intent" "greeting_intent" {
  name     = "GreetingIntent"
  bot_name = aws_lex_bot.my_bot.name
  # ...
}
    