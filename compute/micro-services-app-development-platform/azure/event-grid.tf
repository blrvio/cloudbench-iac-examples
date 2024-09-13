
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um evento de regra
resource "aws_eventbridge_rule" "example_rule" {
  name               = "example_rule"
  event_bus_name     = "default"
  description        = "Exemplo de regra de evento"
  schedule_expression = "rate(5 minutes)"
  targets {
    arn = "arn:aws:lambda:us-east-1:123456789012:function:example_function"
  }
}

    