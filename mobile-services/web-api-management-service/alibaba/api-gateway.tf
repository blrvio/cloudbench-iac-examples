
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um API Gateway REST API
resource "aws_api_gateway_rest_api" "example" {
  name = "example-api"
}

# Crie um recurso API Gateway
resource "aws_api_gateway_resource" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "items"
}

# Crie um método API Gateway
resource "aws_api_gateway_method" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id  = aws_api_gateway_resource.example.id
  http_method  = "GET"
  authorization_type = "NONE"
}

# Crie uma integração API Gateway
resource "aws_api_gateway_integration" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id  = aws_api_gateway_resource.example.id
  http_method  = "GET"
  integration_type = "AWS_PROXY"
  integration_uri   = "arn:aws:lambda:us-east-1:123456789012:function:my-lambda-function"
}

# Crie um deploy API Gateway
resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name = "prod"
}

# Crie uma etapa API Gateway
resource "aws_api_gateway_stage" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name = "prod"
  deployment_id = aws_api_gateway_deployment.example.id
}
    