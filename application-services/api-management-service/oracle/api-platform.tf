
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Configure your Oracle Cloud Infrastructure tenancy
  tenancy_ocid  = "ocid1.tenancy.oc1..aaaaaaaazg7y7f4"
  user_ocid    = "ocid1.user.oc1..aaaaaaaay7j4e5z"
  fingerprint   = "23:39:5f:0a:76:94:20:10:50:1f:0d:85:f6:90:30:98"
  private_key_path = "path/to/your/private/key/file"
  region = "us-ashburn-1"
}

# Create an API Gateway
resource "oci_apigateway_gateway" "main" {
  # Define the API Gateway name
  display_name = "my-api-gateway"
  # Define the compartment OCID where the API Gateway will be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxq6y75b"
  # Define the API Gateway's description
  description = "My API Gateway"
}

# Create an API Platform Deployment
resource "oci_apigateway_deployment" "main" {
  # Define the Deployment name
  display_name = "my-api-deployment"
  # Define the Compartment OCID where the Deployment will be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxq6y75b"
  # Define the API Gateway OCID to which the deployment belongs
  gateway_id = oci_apigateway_gateway.main.id
  # Define the API Platform Deployment's description
  description = "My API Platform Deployment"
}

# Create an API Platform Deployment Revision
resource "oci_apigateway_deployment_revision" "main" {
  # Define the Deployment Revision name
  display_name = "my-api-deployment-revision"
  # Define the Compartment OCID where the Deployment Revision will be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxq6y75b"
  # Define the Deployment OCID to which the Deployment Revision belongs
  deployment_id = oci_apigateway_deployment.main.id
  # Define the API Platform Deployment Revision's description
  description = "My API Platform Deployment Revision"
}

# Create an API Platform Spec
resource "oci_apigateway_spec" "main" {
  # Define the Spec name
  display_name = "my-api-spec"
  # Define the Compartment OCID where the Spec will be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxq6y75b"
  # Define the Spec's description
  description = "My API Platform Spec"
  # Define the Spec's content (JSON or YAML)
  content = <<EOF
# Example OpenAPI 3.0 spec
openapi: 3.0.0
info:
  title: My API
  version: v1
paths:
  /users:
    get:
      summary: Get all users
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                type: array
                items:
                  type: object
                  properties:
                    id:
                      type: integer
                      format: int64
                    name:
                      type: string
                    email:
                      type: string
EOF
}

# Create an API Platform Route
resource "oci_apigateway_route" "main" {
  # Define the Route name
  display_name = "my-api-route"
  # Define the Compartment OCID where the Route will be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxq6y75b"
  # Define the API Gateway OCID to which the Route belongs
  gateway_id = oci_apigateway_gateway.main.id
  # Define the API Platform Deployment Revision OCID to which the Route belongs
  deployment_revision_id = oci_apigateway_deployment_revision.main.id
  # Define the API Platform Spec OCID to which the Route belongs
  spec_id = oci_apigateway_spec.main.id
  # Define the Route's path
  path = "/users"
  # Define the Route's method
  method = "GET"
}

  