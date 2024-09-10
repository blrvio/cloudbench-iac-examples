
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an API Gateway REST API
resource "aws_api_gateway_rest_api" "main" {
  name = "my-api-gateway"
  description = "My API Gateway"

  # Define the API endpoint configuration
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Create an API Gateway Resource
resource "aws_api_gateway_resource" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part  = "items"
}

# Create an API Gateway Method
resource "aws_api_gateway_method" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.main.id
  http_method = "GET"
  authorization = "NONE"

  # Define the integration type for the method
  integration {
    type                      = "AWS_PROXY"
    integration_http_method = "POST"
    # Define the Lambda function to be invoked by the method
    uri = "arn:aws:lambda:us-east-1:123456789012:function:my-lambda-function"
  }
}

# Create an API Gateway Deployment
resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = "dev"
}

# Create an API Gateway Stage
resource "aws_api_gateway_stage" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = "dev"
  deployment_id = aws_api_gateway_deployment.main.id

  # Define the stage options
  options {
    # Disable throttling for the stage
    throttling_burst_limit = 0
    throttling_rate_limit  = 0
  }
}

# Create an API Gateway Integration Response
resource "aws_api_gateway_integration_response" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.main.id
  http_method = "GET"
  status_code = "200"

  # Define the response parameters
  response_parameters = {
    "method.response.header.Content-Type" = "integration.response.header.Content-Type"
  }
}

# Create an API Gateway Method Response
resource "aws_api_gateway_method_response" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.main.id
  http_method = "GET"
  status_code = "200"

  # Define the response parameters
  response_parameters = {
    "method.response.header.Content-Type" = true
  }
}

  