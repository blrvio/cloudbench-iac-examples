
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaakg5m5i"

  # Replace with your user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaaaaaaaaaw6r47"

  # Replace with your API key
  api_key_fingerprint = "fingerprint"
  api_key = "YOUR_API_KEY"
}

# Create an OS Management Instance
resource "oci_osmanagement_instance" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaktgc5"
  # Replace with your Compute Instance OCID
  instance_ocid = "ocid1.instance.oc1..aaaaaaaaaaaaaaaam7n73"
  display_name = "OS Management Instance"
  # Optional: Configure the inventory and security settings
  inventory_settings {
    enable_inventory = true
    enable_security_monitoring = true
  }
}

  