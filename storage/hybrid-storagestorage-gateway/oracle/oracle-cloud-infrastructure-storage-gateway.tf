
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your OCI tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Replace with your OCI user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Replace with your OCI API key
  api_key_file = "~/.oci/config"
}

# Create a storage gateway
resource "oci_core_storage_gateway" "main" {
  availability_domain = "AD-1"
  compartment_id     = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Replace with your desired gateway name
  display_name = "my-storage-gateway"
  # Replace with your desired gateway shape
  shape = "OCI_STORAGE_GATEWAY_SHAPE_1"
}

# Create a volume attachment
resource "oci_core_volume_attachment" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Replace with your volume OCID
  volume_id = "ocid1.volume.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Replace with your storage gateway OCID
  storage_gateway_id = oci_core_storage_gateway.main.id
}

  