
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma função FunctionGraph
resource "aws_lambda_function" "my_function" {
  function_name = "my-function"
  runtime       = "nodejs18.x"
  handler       = "index.handler"
  role          = aws_iam_role.lambda_role.arn
  code          = templatefile("lambda.zip", {})
}

# Crie uma função de IAM para a função FunctionGraph
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }]
  })
}

# Crie uma política de IAM para a função FunctionGraph
resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }]
  })
}

# Adicione a política à função de IAM
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.id
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Define o arquivo zip do código da função (não implementado no exemplo)
template "lambda.zip" {
  ""
}
    