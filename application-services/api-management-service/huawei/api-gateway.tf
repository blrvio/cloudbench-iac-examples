
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um API Gateway REST API
resource "aws_api_gateway_rest_api" "example" {
  name        = "example-api"
  description = "API Gateway REST API example"
}

# Crie um recurso de API Gateway
resource "aws_api_gateway_resource" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "items"
}

# Crie um método de API Gateway
resource "aws_api_gateway_method" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id  = aws_api_gateway_resource.example.id
  http_method  = "GET"
  authorization_type = "NONE"
}

# Crie uma integração de API Gateway
resource "aws_api_gateway_integration" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id  = aws_api_gateway_resource.example.id
  http_method  = "GET"
  integration_type = "AWS_PROXY"
  integration_uri  = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:123456789012:function:my-lambda-function:123456789012/invocations"
}

# Crie um deployment de API Gateway
resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name   = "prod"
}

    