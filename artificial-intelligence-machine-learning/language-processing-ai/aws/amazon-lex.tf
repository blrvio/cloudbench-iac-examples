
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um bot do Amazon Lex
resource "aws_lex_bot" "my_bot" {
  name     = "my_bot"
  locale   = "en-US"
  child_directed = false
  intent_names = ["GreetingIntent"]
}

# Crie uma intenção do Amazon Lex
resource "aws_lex_intent" "greeting_intent" {
  name           = "GreetingIntent"
  bot_name      = aws_lex_bot.my_bot.name
  sample_utterances = ["Hello", "Hi", "Good morning"]
  fulfillment_activity {
    type        = "ReturnIntent"
  }
}

# Crie um slot do Amazon Lex
resource "aws_lex_slot" "name_slot" {
  name           = "NameSlot"
  slot_type_name = "AMAZON.US_FIRST_NAME"
  intent_name    = aws_lex_intent.greeting_intent.name
  bot_name      = aws_lex_bot.my_bot.name
  priority       = 1
}

# Crie um ponto final do Amazon Lex
resource "aws_lex_bot_alias" "my_bot_alias" {
  name    = "my_bot_alias"
  bot_name = aws_lex_bot.my_bot.name
  bot_version = aws_lex_bot.my_bot.version
}

# Crie um slot tipo personalizado do Amazon Lex
resource "aws_lex_slot_type" "custom_slot_type" {
  name    = "CustomSlotType"
  values  = [{"value": "Value1"}, {"value": "Value2"}]
  enumeration_values = [{"value": "Value1", "synonyms": ["Syn1", "Syn2"]}, {"value": "Value2", "synonyms": ["Syn3"]}]
}
    