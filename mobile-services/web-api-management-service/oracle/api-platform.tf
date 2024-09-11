
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaw7w72r777"
  user_ocid  = "ocid1.user.oc1..aaaaaaaamv8934h2"
  fingerprint = "xxx"
  private_key_path = "~/.ssh/id_rsa"
}

# Create an API Gateway
resource "oci_apigateway_gateway" "main" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaayw7w72r777"
  display_name  = "my-api-gateway"
  # Optional parameters
  #  description = "my API gateway"
  #  traffic_management_config { 
  #    enable_traffic_management = false
  #  }
  #  swagger_spec { 
  #    source = "{\"swagger\": \"2.0\", \"info\": {\"title\": \"my API gateway\", \"version\": \"1.0.0\"}, \"paths\": {\"/hello\": {\"get\": {\"description\": \"Returns a Hello World message\", \"responses\": {\"200\": {\"description\": \"Success\"}}}}}}
  #  }
}

# Create an API Deployment
resource "oci_apigateway_deployment" "main" {
  compartment_id = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  display_name   = "my-api-deployment"
  #  spec_content = "{\"swagger\": \"2.0\", \"info\": {\"title\": \"my API gateway\", \"version\": \"1.0.0\"}, \"paths\": {\"/hello\": {\"get\": {\"description\": \"Returns a Hello World message\", \"responses\": {\"200\": {\"description\": \"Success\"}}}}}}
  # Optional parameters
  #  description = "My API deployment"
  #  swagger_spec_content = "{\"swagger\": \"2.0\", \"info\": {\"title\": \"my API gateway\", \"version\": \"1.0.0\"}, \"paths\": {\"/hello\": {\"get\": {\"description\": \"Returns a Hello World message\", \"responses\": {\"200\": {\"description\": \"Success\"}}}}}}
  #  }
}

# Create an API Specification
resource "oci_apigateway_specification" "main" {
  compartment_id = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  display_name   = "my-api-specification"
  #  spec_content = "{\"swagger\": \"2.0\", \"info\": {\"title\": \"my API gateway\", \"version\": \"1.0.0\"}, \"paths\": {\"/hello\": {\"get\": {\"description\": \"Returns a Hello World message\", \"responses\": {\"200\": {\"description\": \"Success\"}}}}}}
  # Optional parameters
  #  description = "My API specification"
  #  swagger_spec_content = "{\"swagger\": \"2.0\", \"info\": {\"title\": \"my API gateway\", \"version\": \"1.0.0\"}, \"paths\": {\"/hello\": {\"get\": {\"description\": \"Returns a Hello World message\", \"responses\": {\"200\": {\"description\": \"Success\"}}}}}}
  #  }
}

# Create an API Route
resource "oci_apigateway_route" "main" {
  compartment_id  = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  deployment_id  = oci_apigateway_deployment.main.id
  display_name  = "my-api-route"
  #  specification_id = oci_apigateway_specification.main.id
  #  route_request { 
  #    method = "GET"
  #    uri_pattern = "/hello"
  #  }
  # Optional parameters
  #  description = "My API route"
  #  route_request { 
  #    method = "GET"
  #    uri_pattern = "/hello"
  #  }
}

# Create an API Key
resource "oci_apigateway_key" "main" {
  compartment_id = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  display_name   = "my-api-key"
  # Optional parameters
  #  description = "My API key"
  #  enabled = true
}

# Create an API Key Usage Plan
resource "oci_apigateway_key_usage_plan" "main" {
  compartment_id = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  display_name   = "my-api-key-usage-plan"
  # Optional parameters
  #  description = "My API key usage plan"
}

# Create an API Key Usage Plan Assignment
resource "oci_apigateway_key_usage_plan_assignment" "main" {
  compartment_id = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  key_id         = oci_apigateway_key.main.id
  usage_plan_id  = oci_apigateway_key_usage_plan.main.id
  # Optional parameters
  #  description = "My API key usage plan assignment"
}

# Create an API Virtual Service
resource "oci_apigateway_virtual_service" "main" {
  compartment_id = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  display_name   = "my-api-virtual-service"
  #  deployment_id = oci_apigateway_deployment.main.id
  #  route_id = oci_apigateway_route.main.id
  # Optional parameters
  #  description = "My API virtual service"
  #  route_id = oci_apigateway_route.main.id
}

# Create an API Virtual Service Route
resource "oci_apigateway_virtual_service_route" "main" {
  compartment_id  = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  virtual_service_id = oci_apigateway_virtual_service.main.id
  display_name  = "my-api-virtual-service-route"
  #  route_id = oci_apigateway_route.main.id
  # Optional parameters
  #  description = "My API virtual service route"
  #  route_id = oci_apigateway_route.main.id
}

# Create an API Virtual Service Route Request
resource "oci_apigateway_virtual_service_route_request" "main" {
  compartment_id  = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  virtual_service_id = oci_apigateway_virtual_service.main.id
  display_name  = "my-api-virtual-service-route-request"
  #  route_id = oci_apigateway_route.main.id
  # Optional parameters
  #  description = "My API virtual service route request"
  #  route_id = oci_apigateway_route.main.id
}

# Create an API Virtual Service Route Response
resource "oci_apigateway_virtual_service_route_response" "main" {
  compartment_id  = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  virtual_service_id = oci_apigateway_virtual_service.main.id
  display_name  = "my-api-virtual-service-route-response"
  #  route_id = oci_apigateway_route.main.id
  # Optional parameters
  #  description = "My API virtual service route response"
  #  route_id = oci_apigateway_route.main.id
}

# Create an API Virtual Service Route Request Header
resource "oci_apigateway_virtual_service_route_request_header" "main" {
  compartment_id  = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  virtual_service_id = oci_apigateway_virtual_service.main.id
  display_name  = "my-api-virtual-service-route-request-header"
  #  route_id = oci_apigateway_route.main.id
  # Optional parameters
  #  description = "My API virtual service route request header"
  #  route_id = oci_apigateway_route.main.id
}

# Create an API Virtual Service Route Response Header
resource "oci_apigateway_virtual_service_route_response_header" "main" {
  compartment_id  = oci_apigateway_gateway.main.compartment_id
  gateway_id     = oci_apigateway_gateway.main.id
  virtual_service_id = oci_apigateway_virtual_service.main.id
  display_name  = "my-api-virtual-service-route-response-header"
  #  route_id = oci_apigateway_route.main.id
  # Optional parameters
  #  description = "My API virtual service route response header"
  #  route_id = oci_apigateway_route.main.id
}
  