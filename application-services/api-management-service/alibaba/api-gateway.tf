
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
  # Add your access key and secret key
  # ...
}

# Create an API Gateway
resource "alicloud_api_gateway_api" "main" {
  # Define API Gateway properties
  group_id       = "example_group_id"
  api_name      = "my_api"
  api_version   = "1.0.0"
  description    = "My API Gateway"
  # Optional: define request configurations
  # request_config = {}
  # Optional: define response configurations
  # response_config = {}
  # Optional: define security configurations
  # security_config = {}
}

# Create an API Group
resource "alicloud_api_gateway_group" "main" {
  # Define API Group properties
  group_name = "my_api_group"
  description = "My API Group"
  # Optional: define CORS configurations
  # cors_config = {}
}

# Create an API Gateway Deployment
resource "alicloud_api_gateway_deployment" "main" {
  # Define Deployment properties
  group_id       = alicloud_api_gateway_group.main.id
  api_id         = alicloud_api_gateway_api.main.id
  deployment_name = "my_api_deployment"
  # Optional: define traffic configurations
  # traffic_config = {}
}

# Create an API Gateway Stage
resource "alicloud_api_gateway_stage" "main" {
  # Define Stage properties
  group_id     = alicloud_api_gateway_group.main.id
  api_id       = alicloud_api_gateway_api.main.id
  stage_name = "prod"
  # Optional: define the deployment to use
  # deployment_id = alicloud_api_gateway_deployment.main.id
  # Optional: define the stage variables
  # variables = {}
}

  