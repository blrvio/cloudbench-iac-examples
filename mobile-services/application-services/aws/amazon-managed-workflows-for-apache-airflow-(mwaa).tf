
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um ambiente MWAA
resource "aws_mwaa_environment" "main" {
  name                       = "my-mwaa-env"
  airflow_version             = "2.2.2"
  airflow_configuration_options = {
    "core.scheduler_interval" = "30"
  }
  # ... outras configurações ...
}

# Crie uma função Lambda para o webhook do MWAA
resource "aws_lambda_function" "mwaa_webhook" {
  function_name = "mwaa-webhook"
  runtime       = "python3.9"
  handler       = "main.handler"
  role          = aws_iam_role.mwaa_webhook_role.arn
  # ... outras configurações ...
}

# Crie um papel IAM para a função Lambda
resource "aws_iam_role" "mwaa_webhook_role" {
  name               = "mwaa-webhook-role"
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

# Adicione uma política IAM à função Lambda para permitir o acesso ao ambiente MWAA
resource "aws_iam_role_policy" "mwaa_webhook_policy" {
  name   = "mwaa-webhook-policy"
  role   = aws_iam_role.mwaa_webhook_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "mwaa:GetEnvironment",
          "mwaa:UpdateEnvironment",
          "mwaa:DeleteEnvironment"
        ],
        "Resource": "arn:aws:mwaa:*:123456789012:environment/my-mwaa-env"
      }
    ]
  })
}

# Adicione uma política IAM à função Lambda para permitir o acesso ao S3
resource "aws_iam_role_policy" "mwaa_webhook_s3_policy" {
  name   = "mwaa-webhook-s3-policy"
  role   = aws_iam_role.mwaa_webhook_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource": "arn:aws:s3:::my-bucket/*"
      }
    ]
  })
}
    