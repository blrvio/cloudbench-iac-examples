
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your desired region
  # Add your authentication details here
}

# Create an API Catalog
resource "oci_apigateway_api_catalog" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  display_name  = "My API Catalog"
  description    = "Example API Catalog"
}

# Create an API in the API Catalog
resource "oci_apigateway_api" "main" {
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  api_catalog_id = oci_apigateway_api_catalog.main.id
  display_name   = "My API"
  description     = "Example API"
  # Add your API specification details here
}

  