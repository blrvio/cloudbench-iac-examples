
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma fila SQS
resource "aws_sqs_queue" "example" {
  name = "example-queue"
}

# Envie uma mensagem para a fila SQS
resource "aws_sqs_queue_message" "example" {
  queue_url = aws_sqs_queue.example.id
  message_body = "Hello, world!"
}
    