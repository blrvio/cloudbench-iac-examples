
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create an API Gateway
resource "alicloud_api_gateway_api" "main" {
  group_id = "your_api_group_id" # Replace with your desired API Group ID
  api_name = "my-api"
  api_description = "My API Gateway"
  # ... other properties
}

# Create a API Group
resource "alicloud_api_gateway_group" "main" {
  group_name  = "my-api-group"
  group_type = "HTTP"
  # ... other properties
}

# Create a API Deployment
resource "alicloud_api_gateway_deployment" "main" {
  api_group_id = alicloud_api_gateway_group.main.id
  api_id = alicloud_api_gateway_api.main.id
  stage_name = "prod"
}

  