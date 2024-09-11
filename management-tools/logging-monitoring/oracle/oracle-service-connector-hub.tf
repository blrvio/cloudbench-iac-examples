
    # Configure the Oracle provider
provider "oracle" {
  # Replace with your Oracle Cloud Infrastructure (OCI) credentials
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Add other provider configuration as needed
}

# Create an Oracle Service Connector Hub Instance
resource "oci_service_connector_hub_instance" "main" {
  # Replace with your desired values
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  display_name = "My Service Connector Hub Instance"
  # Configure additional instance settings as needed
}

# Define a Service Connector for the hub
resource "oci_service_connector_hub_service_connector" "main" {
  # Replace with your desired values
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  hub_instance_id = oci_service_connector_hub_instance.main.id
  service_name = "your_service_name"
  # Configure other service connector properties as needed
}
  