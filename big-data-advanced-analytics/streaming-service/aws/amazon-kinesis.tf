
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um stream do Kinesis
resource "aws_kinesis_stream" "example" {
  name            = "example"
  shard_count     = 1
  retention_period = 24
}

# Crie uma função Lambda para processar os dados do stream
resource "aws_lambda_function" "example" {
  function_name = "example"
  runtime        = "python3.9"
  handler        = "main.handler"
  role           = aws_iam_role.lambda_role.arn
  code = {
    zip_file = "# Código da função Lambda"
  }
  timeout         = 10
  memory_size     = 128
}

# Crie uma role IAM para a função Lambda
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

# Adicione uma política IAM para a role da função Lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:DescribeStream",
        "kinesis:GetShardIterator",
        "kinesis:GetRecords"
      ],
      "Resource": "arn:aws:kinesis:*:*:stream/${aws_kinesis_stream.example.name}"
    }
  ]
}
EOF
}

# Configure um evento do Lambda para processar os dados do stream
resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn = aws_kinesis_stream.example.arn
  function_name    = aws_lambda_function.example.function_name
  batch_size       = 100
  starting_position = "LATEST"
}

    