
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..."
  user = "ocid1.user.oc1..."
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxx"
  key_file = "~/.oci/oci_api_key.pem"
}

# Create a REST API
resource "oci_apigateway_rest_api" "main" {
  display_name = "My REST API"
  compartment_id = "ocid1.compartment.oc1..."
  api_version = "20201201"
  # Optional parameters:
  # description = "A description of the REST API"
  # spec_url = "https://example.com/api-spec.yaml"
  # spec_content = "yaml-content"
}

# Create a resource for the REST API
resource "oci_apigateway_resource" "main" {
  rest_api_id = oci_apigateway_rest_api.main.id
  resource_path = "/users"
  # Optional parameters:
  # display_name = "My Resource"
  # description = "A description of the resource"
}

# Create a method for the REST API
resource "oci_apigateway_method" "main" {
  rest_api_id = oci_apigateway_rest_api.main.id
  resource_id = oci_apigateway_resource.main.id
  method = "GET"
  # Optional parameters:
  # display_name = "My Method"
  # description = "A description of the method"
  # request_model = "my-request-model"
  # response_model = "my-response-model"
  # authorization_type = "NONE"
  # authorization_scopes = ["scope1", "scope2"]
}

# Create a deployment for the REST API
resource "oci_apigateway_deployment" "main" {
  rest_api_id = oci_apigateway_rest_api.main.id
  # Optional parameters:
  # description = "A description of the deployment"
  # deployment_stage = "prod"
}

  