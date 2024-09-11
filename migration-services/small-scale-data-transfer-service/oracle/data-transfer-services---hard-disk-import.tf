
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Specify your OCI configuration here
  # Refer to the OCI provider documentation for details
  # ...
}

# Create a data transfer service
resource "oci_data_transfer_service" "main" {
  # ...
}

# Create a hard disk import job
resource "oci_data_transfer_hard_disk_import_job" "main" {
  # ...
}

# This is a basic example, and you may need to adjust
# it based on your specific use case and OCI configuration.
  