
    # Configure the Oracle Cloud provider
provider "oci" {
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaw7g57r7e"
}

# Create a Data Transfer service
resource "oci_data_transfer_service" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaayg65m7n3"
  display_name   = "my-data-transfer-service"
  # Define the source details, using a specific example for demonstration purposes.
  source {
    type = "object_storage"
    object_storage {
      namespace = "my-namespace"
      bucket    = "my-bucket"
    }
  }
  # Define the destination details
  destination {
    type = "object_storage"
    object_storage {
      namespace = "my-namespace"
      bucket    = "my-destination-bucket"
    }
  }
}

  