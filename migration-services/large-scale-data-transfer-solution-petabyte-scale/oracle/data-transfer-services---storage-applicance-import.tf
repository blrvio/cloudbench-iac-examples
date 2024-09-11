
    # This is an example Terraform configuration for Oracle Cloud Infrastructure Data Transfer Service.
# This example demonstrates importing data from an appliance to an Oracle Cloud Infrastructure Object Storage bucket.

# Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaz7xxxxx"
  user    = "ocid1.user.oc1..aaaaaaaay7xxxxx"
  key     = "your-api-key"
}

# Define the Object Storage bucket for the data import
resource "oci_objectstorage_bucket" "example_bucket" {
  namespace  = "your-namespace"
  name       = "example-bucket"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7xxxxx"
}

# Create a Data Transfer job to import the data from the appliance
resource "oci_data_transfer_job" "example_job" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7xxxxx"
  display_name   = "Example Data Transfer Job"
  source_type      = "APPLIANCE"
  destination_type = "OBJECT_STORAGE"
  # Define the details of the appliance
  source_details {
    appliance_details {
      # Replace with your appliance details
      appliance_type = "HP DL380 Gen10"
      # ... other appliance details
    }
  }
  # Define the details of the Object Storage bucket
  destination_details {
    object_storage_details {
      namespace       = oci_objectstorage_bucket.example_bucket.namespace
      bucket_name    = oci_objectstorage_bucket.example_bucket.name
      destination_path = "your-path-in-bucket"
    }
  }
}

  