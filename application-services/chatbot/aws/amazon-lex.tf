
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon Lex Bot
resource "aws_lex_bot" "main" {
  name        = "my-lex-bot"
  # Choose the bot's language
  locale      = "en-US"
  # Choose a bot's child directed setting
  child_directed = false
  # Set the bot's IAM role ARN
  role_arn = aws_iam_role.lex_bot_role.arn

  # Define the bot's intents
  intents {
    intent_name = "GreetingIntent"
    # Define the intent's slots
    slots {
      slot_name  = "Name"
      slot_type   = "AMAZON.US_FIRST_NAME"
      # Add a sample utterance for the slot
      sample_utterances = ["My name is {Name}"]
    }
  }
}

# Create an IAM role for the Amazon Lex bot
resource "aws_iam_role" "lex_bot_role" {
  name = "lex_bot_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lex.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  # Add permissions for the bot to access the required services
  # For example, allow access to Amazon S3 to store bot data
  # aws_iam_role_policy_attachment.lex_bot_role_policy (resource below)
}

# Attach an IAM policy to the bot's role
resource "aws_iam_role_policy_attachment" "lex_bot_role_policy" {
  role       = aws_iam_role.lex_bot_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonLexFullAccess"
}

# Create an Amazon Lex slot type
resource "aws_lex_slot_type" "main" {
  name         = "City"
  # Define the slot type's values
  enumeration_values {
    value = "New York"
  }
  enumeration_values {
    value = "London"
  }
  # Add a sample utterance for the slot
  sample_utterances = ["{City}"]
}

# Create an Amazon Lex utterance
resource "aws_lex_utterance" "main" {
  bot_name = aws_lex_bot.main.name
  intent_name = "GreetingIntent"
  # Define the utterance's text
  utterance = "Hello, I am {Name}"
}

  