
    # Configure the provider for Huawei Cloud
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create an API Gateway instance
resource "huaweicloud_apig_instance" "main" {
  name = "my-api-gateway"
  # Optional settings
  description = "My API Gateway Instance"
  tags = {
    "Key1" = "Value1"
  }
}

# Create an API Gateway API
resource "huaweicloud_apig_api" "main" {
  name = "my-api"
  instance_id = huaweicloud_apig_instance.main.id
  # Define the API configuration
  api_type = "rest"
  # Define the API's request configuration
  request_config {
    # Set the content type of the API's request
    content_type = "application/json"
  }
  # Define the API's response configuration
  response_config {
    # Set the content type of the API's response
    content_type = "application/json"
  }
}

# Create an API Gateway API Key
resource "huaweicloud_apig_apikey" "main" {
  name = "my-api-key"
  instance_id = huaweicloud_apig_instance.main.id
  # Define the API Key's description
  description = "My API Key"
  # Set the API Key's status
  status = "active"
}

  