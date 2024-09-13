
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um API Gateway REST API
resource "aws_api_gateway_rest_api" "example" {
  name = "example-api"
}

# Crie um recurso API Gateway
resource "aws_api_gateway_resource" "example_resource" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "items"
}

# Crie um método API Gateway
resource "aws_api_gateway_method" "example_method" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id  = aws_api_gateway_resource.example_resource.id
  http_method  = "GET"
  authorization_type = "NONE"
}

# Crie uma integração API Gateway
resource "aws_api_gateway_integration" "example_integration" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id  = aws_api_gateway_resource.example_resource.id
  http_method  = "GET"
  integration_type = "AWS_PROXY"
  integration_uri = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:xxxxxxxxxxxx:function:example-function:xxxxxxxxxxxx/invocations"
}

# Crie uma implantação API Gateway
resource "aws_api_gateway_deployment" "example_deployment" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name = "dev"
}

    