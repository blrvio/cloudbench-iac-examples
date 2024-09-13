
      # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  user    = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  key     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

# Create a registry
resource "oci_registry_repository" "example" {
  namespace = "mynamespace"
  name       = "myregistry"
}

# Create a namespace
resource "oci_registry_namespace" "example" {
  name  = "mynamespace"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
}

# Upload an image to the registry
resource "oci_registry_image" "example" {
  namespace  = "mynamespace"
  repository = "myregistry"
  image_name  = "myimage:latest"
  manifest   = "oci_registry_image.example.manifest"
  tags       = {
    "key" = "value"
  }
}
    