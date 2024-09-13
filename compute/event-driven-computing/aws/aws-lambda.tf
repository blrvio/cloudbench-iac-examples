
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um papel IAM para a função Lambda
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

# Crie uma política IAM para a função Lambda
resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_policy"
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

# Anexa a política ao papel IAM
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role = aws_iam_role.lambda_role.id
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Crie a função Lambda
resource "aws_lambda_function" "my_lambda_function" {
  function_name = "my_lambda_function"
  runtime       = "nodejs16.x"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  code = {
    zip_file = "# Código da função Lambda"
  }
}

    