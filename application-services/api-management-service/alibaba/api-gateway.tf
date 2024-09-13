
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um REST API
resource "aws_api_gateway_rest_api" "my_api" {
  name = "My API"
}

# Crie um recurso para a API
resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "myresource"
}

# Crie um método para o recurso
resource "aws_api_gateway_method" "my_method" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id  = aws_api_gateway_resource.my_resource.id
  http_method = "GET"
  authorization_type = "NONE"
}

# Crie uma integração para o método
resource "aws_api_gateway_integration" "my_integration" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id    = aws_api_gateway_resource.my_resource.id
  http_method    = aws_api_gateway_method.my_method.http_method
  integration_type = "AWS_PROXY"
  integration_uri  = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:123456789012:function:my-function/invocations"
}

# Crie um modelo de resposta para a integração
resource "aws_api_gateway_integration_response" "my_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id    = aws_api_gateway_resource.my_resource.id
  http_method    = aws_api_gateway_method.my_method.http_method
  status_code    = "200"
  selection_pattern = "(.*)"
  response_templates = {
    "application/json" = "{\"message\": \"Hello from API Gateway!\"}"
  }
}

    