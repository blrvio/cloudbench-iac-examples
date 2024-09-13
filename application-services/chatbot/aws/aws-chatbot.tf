
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um chatbot
resource "aws_chatbot_channel" "default" {
  name   = "MyChatbot"
  type   = "slack"
  role_arn = "arn:aws:iam::123456789012:role/chatbot-role"
  configuration = <<EOF
{
  "Slack": {
    "Channel": "#general",
    "Token": "xoxb-xxxxxxxxxxxxxxxxxxxxxxxx"
  }
}
EOF
}

    