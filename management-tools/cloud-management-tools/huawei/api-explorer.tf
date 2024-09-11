
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "us-east-1" # Replace with your desired region
}

# Create a sample API Gateway service
resource "huaweicloud_apig_service" "sample" {
  name   = "sample-api-gateway"
  # Replace with your actual description
  description = "A sample API Gateway service"
}

# Create a sample API Gateway API
resource "huaweicloud_apig_api" "sample" {
  name        = "sample-api"
  service_id = huaweicloud_apig_service.sample.id
  description = "A sample API"
  # Replace with your actual API configuration
  # See the API Explorer documentation for more details
  config = <<EOF
{
  "protocols": [
    "https"
  ],
  "methods": [
    "GET"
  ],
  "request_config": {
    "uri": "/api/v1/sample"
  },
  "response_config": {
    "success_code": 200
  }
}
EOF
}

# Create a sample API Gateway resource
resource "huaweicloud_apig_resource" "sample" {
  name        = "sample-resource"
  service_id = huaweicloud_apig_service.sample.id
  api_id      = huaweicloud_apig_api.sample.id
  path        = "/sample"
}

# Create a sample API Gateway deployment
resource "huaweicloud_apig_deployment" "sample" {
  name        = "sample-deployment"
  service_id = huaweicloud_apig_service.sample.id
  api_id      = huaweicloud_apig_api.sample.id
  # Replace with your actual deployment configuration
  # See the API Explorer documentation for more details
  config = <<EOF
{
  "environment": "test"
}
EOF
}

  