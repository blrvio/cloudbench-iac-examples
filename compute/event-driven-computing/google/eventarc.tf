
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um EventBus
resource "aws_eventarc_event_bus" "example" {
  name = "example"
}

# Crie uma regra de evento
resource "aws_eventarc_rule" "example" {
  name = "example"
  event_bus_name = aws_eventarc_event_bus.example.name
  event_pattern = <<EOF
{
  "source": ["aws.ec2"
  ],
  "detail-type": ["EC2 Instance State-change Notification"
  ]
}
EOF
  targets {
    id  = aws_lambda_function.example.arn
    arn = aws_lambda_function.example.arn
  }
}

# Crie uma função Lambda
resource "aws_lambda_function" "example" {
  function_name = "example"
  runtime = "nodejs16.x"
  handler = "index.handler"
  role = aws_iam_role.example.arn
  code = { # Replace with your lambda code
    zip_file = "# code"
  }
}

# Crie um papel IAM para a função Lambda
resource "aws_iam_role" "example" {
  name = "example"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Adicione uma política IAM para o papel Lambda
resource "aws_iam_role_policy" "example" {
  name = "example"
  role = aws_iam_role.example.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "events:PutEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
    