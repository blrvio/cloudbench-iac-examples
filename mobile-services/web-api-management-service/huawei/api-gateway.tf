
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create an API Gateway API
resource "huaweicloud_apig_api" "main" {
  name     = "my-api"
  protocol = "HTTP"
  # Define the API endpoint
  endpoint_config {
    type      = "EDGE"
    subdomain = "my-api-endpoint"
    path      = "/"
  }
  # Define the API authorization
  auth_config {
    type = "NONE"
  }
}

# Create an API Gateway resource
resource "huaweicloud_apig_resource" "main" {
  api_id     = huaweicloud_apig_api.main.id
  path       = "/my-resource"
  parent_path = "/"
  # Define the resource authorization
  auth_config {
    type = "NONE"
  }
}

# Create an API Gateway method
resource "huaweicloud_apig_method" "main" {
  api_id       = huaweicloud_apig_api.main.id
  resource_id  = huaweicloud_apig_resource.main.id
  http_method = "GET"
  # Define the method authorization
  auth_config {
    type = "NONE"
  }
  # Define the method integration
  integration {
    type = "MOCK"
    # Define the integration response
    integration_response {
      selection_pattern = "*/200"
      response_template = "{"message": "Hello, world!"}"
    }
  }
}

  