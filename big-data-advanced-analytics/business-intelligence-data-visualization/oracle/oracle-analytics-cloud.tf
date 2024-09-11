
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Replace with your tenancy OCID
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Replace with your user OCID
  user_ocid  = "ocid1.user.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Replace with your region
  region = "us-ashburn-1"
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"

  # Optional configuration for authentication
  # If using API keys, provide the key and secret
  # api_key_file = "/path/to/api/key"
  # api_secret = "your-api-secret"

  # If using instance principals, set this to "true"
  # instance_principals = true
}

# Create an Analytics Cloud service
resource "oci_analytics_cloud_service" "main" {
  # Replace with your desired name for the service
  display_name = "my-analytics-cloud-service"
  # Replace with your desired description
  description  = "My Analytics Cloud Service"
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Choose a supported edition for the service
  edition = "enterprise"
}

  