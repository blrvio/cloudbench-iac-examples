
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
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

# Attach the necessary policies to the IAM role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Create a Lambda function
resource "aws_lambda_function" "main" {
  function_name = "my-lambda-function"
  runtime       = "nodejs16.x"
  handler       = "index.handler"
  role          = aws_iam_role.lambda_role.arn
  filename      = "lambda_function.zip"
  # This will create a zip file in the current directory named 'lambda_function.zip'
  # You will need to replace the contents of this zip file with your Lambda function code
  # You can also use a S3 bucket to store your Lambda function code
  # For more information, see: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

  # Optional settings
  memory_size = 128
  timeout     = 30
  publish     = true
}

# Create an API Gateway endpoint for the Lambda function
resource "aws_api_gateway_rest_api" "main" {
  name = "my-lambda-api"
}

resource "aws_api_gateway_resource" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "my-lambda-path"
}

resource "aws_api_gateway_method" "main" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.main.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "main" {
  rest_api_id      = aws_api_gateway_rest_api.main.id
  resource_id      = aws_api_gateway_resource.main.id
  http_method      = "GET"
  integration_type = "aws_proxy"
  integration_uri  = aws_lambda_function.main.invoke_arn
}

  