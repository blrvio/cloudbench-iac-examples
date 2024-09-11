
    # Configure the provider for Oracle Cloud
provider "oci" {
  # Replace with your Oracle Cloud region
  region = "us-ashburn-1"
}

# Create an Apiary API
resource "oci_apiary_api" "main" {
  # Replace with a valid API name
  api_name = "my-api"
  # Replace with a valid API description
  description = "This is my API"
  # Replace with a valid API gateway
  gateway_id = oci_apiary_gateway.main.id
}

# Create an Apiary Gateway
resource "oci_apiary_gateway" "main" {
  # Replace with a valid gateway name
  gateway_name = "my-gateway"
  # Replace with a valid compartment ID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

# Create an Apiary Endpoint
resource "oci_apiary_endpoint" "main" {
  # Replace with a valid endpoint name
  endpoint_name = "my-endpoint"
  # Replace with a valid API ID
  api_id = oci_apiary_api.main.id
  # Replace with a valid gateway ID
  gateway_id = oci_apiary_gateway.main.id
}

  