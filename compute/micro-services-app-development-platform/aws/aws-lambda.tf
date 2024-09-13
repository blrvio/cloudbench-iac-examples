
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie uma função Lambda
resource "aws_lambda_function" "hello_world" {
  function_name = "hello_world"
  runtime        = "nodejs16.x"
  handler       = "index.handler"
  role          = aws_iam_role.lambda_role.arn
  code = {
    zip_file = "# Arquivo zip do código Lambda"
  }
}

# Crie uma função IAM para a Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
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

# Adicione permissões IAM para a Lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}
    