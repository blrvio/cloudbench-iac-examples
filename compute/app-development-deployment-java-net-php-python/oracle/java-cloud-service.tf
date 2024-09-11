
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your desired region
  # Add your credentials using the OCI provider documentation
}

# Create a Java Cloud Service instance
resource "oci_java_instance" "main" {
  # Add your configuration here
  # Refer to the OCI Terraform provider documentation for available options
  # Example for minimal configuration:
  # instance_name = "my-java-instance"
  # instance_shape = "VM.Standard.E2.1"
}

# Optional: Create a Java Cloud Service deployment
# resource "oci_java_deployment" "main" {
#   # Add your deployment configuration here
#   # Refer to the OCI Terraform provider documentation for available options
#   # Example for minimal configuration:
#   instance_id = oci_java_instance.main.id
#   # Optional attributes for deployment
# }

  