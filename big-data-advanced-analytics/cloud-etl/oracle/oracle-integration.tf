
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  # Add your tenancy OCID, user OCID and API key
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxxx"
  api_key = "your_api_key"
}

# Create an Oracle Integration Instance
resource "oci_integration_instance" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name   = "my-integration-instance"
  # Add optional parameters like `shape` and `subnet_id`
}

# Create an Oracle Integration Connection
resource "oci_integration_connection" "main" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name    = "my-integration-connection"
  integration_instance_id = oci_integration_instance.main.id
  connection_type = "rest"
  # Add optional parameters like `authentication_details` and `endpoint`
}

# Create an Oracle Integration Integration
resource "oci_integration_integration" "main" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name    = "my-integration"
  integration_instance_id = oci_integration_instance.main.id
  integration_type = "rest"
  # Add optional parameters like `source_connection_id`, `target_connection_id`, and `integration_definition`
}
  