
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um EventBus
resource "aws_eventarc_eventbus" "example" {
  name = "example"
}

# Crie uma regra de evento
resource "aws_eventarc_rule" "example" {
  name   = "example"
  event_bus_name = aws_eventarc_eventbus.example.name
  event_pattern = <<EOF
{"source": ["aws.s3"], "detail-type": ["AWS API Call","AWS Service Event"]}
EOF
}

# Configure uma ação para a regra de evento
resource "aws_eventarc_action" "example" {
  name   = "example"
  rule_name = aws_eventarc_rule.example.name
  target {
    function_arn = "arn:aws:lambda:us-east-1:123456789012:function:my-function"
  }
}

    