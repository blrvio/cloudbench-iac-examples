
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud Infrastructure region
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaab777777777777777777777777"
  # Replace with your Oracle Cloud Infrastructure tenancy ID
  user_ocid = "ocid1.user.oc1..aaaaaaaab777777777777777777777777"
  # Replace with your Oracle Cloud Infrastructure user OCID
  fingerprint = "" # Replace with your Oracle Cloud Infrastructure fingerprint
  # Set your private key file path
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Create a new OCI Registry
resource "oci_container_registry" "main" {
  name = "my-registry"
  # Replace with your desired registry name
  compartment_id = "ocid1.compartment.oc1..aaaaaaaab777777777777777777777777"
  # Replace with your Oracle Cloud Infrastructure compartment ID
}

# Create a new repository within the OCI registry
resource "oci_container_repository" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaab777777777777777777777777"
  # Replace with your Oracle Cloud Infrastructure compartment ID
  registry_id = oci_container_registry.main.id
  name = "my-repository"
  # Replace with your desired repository name
}

  