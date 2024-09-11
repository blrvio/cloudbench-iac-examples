
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxx"
  # Set the compartment ID for resources
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
}

# Create a registry resource
resource "oci_container_registry" "example" {
  name     = "my-registry"
  # Set the compartment ID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
  # Create a unique name
  display_name = "My Registry"
  # Set the description
  description = "My Registry Description"
  # Set the resource's tags
  freeform_tags = {
    Owner = "My Team"
  }
}

# Create an image resource
resource "oci_container_image" "example" {
  # Set the registry namespace
  registry_namespace = oci_container_registry.example.name
  name     = "my-image"
  # Set the compartment ID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
  # Create a unique name
  display_name = "My Image"
  # Set the description
  description = "My Image Description"
  # Set the resource's tags
  freeform_tags = {
    Owner = "My Team"
  }
  # Create the manifest and push the image
  source  = "docker-registry:1.0.0"
  # Set the image's source URI
  source_uri = "docker.io/library/nginx"
}

  