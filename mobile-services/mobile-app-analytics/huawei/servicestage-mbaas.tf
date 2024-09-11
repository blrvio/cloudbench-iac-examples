
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region  = "cn-north-1"
  # Replace with your preferred region
}

# Create a ServiceStage application
resource "huaweicloud_servicestage_application" "main" {
  name    = "my-servicestage-app"
  # Define the desired backend service type
  backend_type = "http"
  # Optional parameters
  # billing_mode = "prepaid"
  # description = "My ServiceStage App"
  # tags = {
    # Key1 = "Value1"
    # Key2 = "Value2"
  # }
}

# Create a ServiceStage service
resource "huaweicloud_servicestage_service" "main" {
  app_id = huaweicloud_servicestage_application.main.id
  # Define a descriptive name for the service
  name     = "my-service"
  # Define the service type
  service_type = "http"
  # Optional parameters
  # description = "My Service"
  # tags = {
    # Key1 = "Value1"
    # Key2 = "Value2"
  # }
}

# Create a ServiceStage API gateway
resource "huaweicloud_servicestage_api_gateway" "main" {
  service_id = huaweicloud_servicestage_service.main.id
  # Define the API gateway name
  name     = "my-api-gateway"
  # Optional parameters
  # api_gateway_type = "http"
  # description = "My API Gateway"
  # tags = {
    # Key1 = "Value1"
    # Key2 = "Value2"
  # }
}

# Create a ServiceStage API route
resource "huaweicloud_servicestage_api_route" "main" {
  api_gateway_id = huaweicloud_servicestage_api_gateway.main.id
  # Define the API route name
  name     = "my-api-route"
  # Define the API route path
  path     = "/api/v1"
  # Define the API route method
  method   = "GET"
  # Optional parameters
  # description = "My API Route"
  # tags = {
    # Key1 = "Value1"
    # Key2 = "Value2"
  # }
}

  