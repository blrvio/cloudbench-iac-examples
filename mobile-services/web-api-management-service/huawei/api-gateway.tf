
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma API Gateway REST API
resource "aws_api_gateway_rest_api" "example" {
  name        = "example"
  description = "Example API Gateway"
}

# Crie um recurso da API
resource "aws_api_gateway_resource" "example_resource" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "items"
}

# Crie um método da API
resource "aws_api_gateway_method" "example_method" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id  = aws_api_gateway_resource.example_resource.id
  http_method  = "GET"
  authorization_type = "NONE"
}

# Crie uma integração da API
resource "aws_api_gateway_integration" "example_integration" {
  rest_api_id  = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.example_resource.id
  http_method   = "GET"
  integration_type = "AWS_PROXY"
  integration_uri  = "arn:aws:lambda:us-east-1:123456789012:function:example-function"
}

# Crie um modelo de resposta
resource "aws_api_gateway_integration_response" "example_integration_response" {
  rest_api_id     = aws_api_gateway_rest_api.example.id
  resource_id      = aws_api_gateway_resource.example_resource.id
  http_method      = "GET"
  status_code      = "200"
  selection_pattern = "$default"
  content_handling  = "CONVERT_TO_TEXT"
}

# Crie um modelo de solicitação
resource "aws_api_gateway_request_validator" "example_request_validator" {
  rest_api_id  = aws_api_gateway_rest_api.example.id
  name         = "example_validator"
  validate_request_body = true
}

# Crie um modelo de deployment
resource "aws_api_gateway_deployment" "example_deployment" {
  rest_api_id  = aws_api_gateway_rest_api.example.id
  stage_name   = "prod"
  stage_description = "Production stage"
}

# Crie uma definição de recurso
resource "aws_api_gateway_resource" "example_resource_definition" {
  rest_api_id  = aws_api_gateway_rest_api.example.id
  parent_id     = aws_api_gateway_rest_api.example.root_resource_id
  path_part     = "items"

  # Crie um método GET
  method {
    http_method     = "GET"
    authorization_type = "NONE"

    # Crie uma integração
    integration {
      integration_type = "AWS_PROXY"
      integration_uri  = "arn:aws:lambda:us-east-1:123456789012:function:example-function"
    }
  }
}
    