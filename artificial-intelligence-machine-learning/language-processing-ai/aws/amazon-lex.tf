
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

# Create a Lex Bot
resource "aws_lex_bot" "main" {
  name     = "MyLexBot"  # Name of your Lex bot
  locale   = "en-US"     # Locale of the bot (English)
  child_directed = false   # Indicate if the bot is for children
  # Define the intent to be used by the bot
  intent {
    name         = "GreetingIntent"
    fulfillment_activity {
      type = "ReturnIntent"
    }
    slot {
      name  = "Name"
      type  = "AMAZON.US_FIRST_NAME"
      slot_constraint = "Required"
    }
    sample_utterances = [
      "Hello",
      "Hi",
      "Good morning",
      "What's up",
      "Hey {Name}",
    ]
  }
}

# Create a Lex Bot Alias
resource "aws_lex_bot_alias" "main" {
  bot_name  = aws_lex_bot.main.name
  bot_version = aws_lex_bot.main.version
  name       = "ProdAlias"
  # Set the bot alias as the production version
  checksum = aws_lex_bot.main.checksum
}

# Create a Lex Bot Channel
resource "aws_lex_bot_channel" "main" {
  bot_name  = aws_lex_bot.main.name
  bot_alias = aws_lex_bot_alias.main.name
  channel_type = "Facebook"
  # Configure the Facebook channel settings
  facebook_config {
    page_id    = "YOUR_FACEBOOK_PAGE_ID"
    app_secret = "YOUR_FACEBOOK_APP_SECRET"
  }
}

  