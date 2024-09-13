
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um evento EventArc
resource "aws_eventarc_event_bus" "example" {
  name = "my-event-bus"
  description = "Event bus for example events"
  event_bus_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:user/example-user"
      },
      "Action": [
        "events:PutEvents"
      ],
      "Resource": "arn:aws:events:us-east-1:123456789012:event-bus/my-event-bus"
    }
  ]
}
EOF
}

# Crie uma regra de evento
resource "aws_eventarc_rule" "example" {
  name        = "my-rule"
  event_bus_name = aws_eventarc_event_bus.example.name
  event_pattern = <<EOF
{
  "source": [
    "aws.ec2"
  ]
}
EOF
  targets = {
    "my-target" = {
      "arn": "arn:aws:lambda:us-east-1:123456789012:function:my-lambda-function"
    }
  }
}

    