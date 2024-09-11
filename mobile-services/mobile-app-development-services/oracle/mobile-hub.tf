
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..."
  user    = "ocid1.user.oc1..."
  key     = "your_api_key"
  fingerprint = "your_api_key_fingerprint"
}

# Create a Mobile Hub instance
resource "oci_mobile_hub_instance" "main" {
  display_name = "My Mobile Hub Instance"
  # other options may be required depending on your use case
}

# Create a Mobile Hub application
resource "oci_mobile_hub_application" "main" {
  display_name = "My Mobile Hub Application"
  instance_id = oci_mobile_hub_instance.main.id
  # other options may be required depending on your use case
}

  