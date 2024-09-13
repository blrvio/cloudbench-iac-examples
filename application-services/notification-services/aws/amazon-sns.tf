
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um tópico SNS
resource "aws_sns_topic" "example" {
  name = "example-topic"
}

# Publique uma mensagem no tópico
resource "aws_sns_topic_publication" "example" {
  topic_arn = aws_sns_topic.example.arn
  message   = "Hello from Terraform!"
}
    