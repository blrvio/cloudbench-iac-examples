
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma regra de evento
resource "aws_eventbridge_rule" "my_rule" {
  name          = "my_rule"
  description   = "Minha regra de evento"
  event_pattern = <<EOF
{
  "source": ["aws.ec2"
  ],
  "detail-type": ["EC2 Instance State-change Notification"
  ],
  "detail": {
    "state": ["running"
    ]
  }
}
EOF
  schedule_expression = "cron(0 0 * * ? *) # Executa diariamente às 00:00"
}

# Crie uma meta de destino para a regra de evento
resource "aws_eventbridge_target" "my_target" {
  rule     = aws_eventbridge_rule.my_rule.name
  arn       = "arn:aws:lambda:us-east-1:123456789012:function:my_lambda_function"
  input_path = "$.detail"
}

    