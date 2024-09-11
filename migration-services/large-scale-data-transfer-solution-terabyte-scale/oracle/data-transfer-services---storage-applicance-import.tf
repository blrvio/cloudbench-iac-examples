
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Replace with your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaz7xxxxxxxxxxxxx"
  # Replace with your user OCID
  user_ocid    = "ocid1.user.oc1..aaaaaaaaz7xxxxxxxxxxxxx"
  # Replace with your region
  region        = "us-ashburn-1"
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7xxxxxxxxxxxxx"
}

# Create a data transfer service job
resource "oci_data_transfer_service_job" "main" {
  # Replace with your storage appliance details
  appliance_details { storage_appliance_type = "hp_dle_x1000"
  }
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7xxxxxxxxxxxxx"
  # Replace with your source and destination details
  source_details {  }
  # Replace with your source and destination details
  destination_details {  }
}

  