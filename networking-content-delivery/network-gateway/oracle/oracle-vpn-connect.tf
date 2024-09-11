
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your actual region and credentials
  # You can set the credentials directly within the provider block or use
  # environment variables for security.
}

# Create a VPN Connect connection
resource "oci_core_vpn_connection" "main" {
  # Replace with your actual values
  # For example, to create a connection from a customer premises to Oracle Cloud
  # you would use `customer_premises_type`
  customer_premises_type = "CUSTOMER_PREMISES"
  # Define the name for the connection
  display_name = "my-vpn-connection"
  # Replace with your actual subnet details for the connection
  # See: https://docs.cloud.oracle.com/en-us/iaas/api/#/en/core/20160918/Subnet
  subnet_id = "ocid1.subnet.oc1.example.subnet_id"
  # Replace with your actual gateway details for the connection
  # See: https://docs.cloud.oracle.com/en-us/iaas/api/#/en/core/20160918/VirtualCircuit
  virtual_circuit_id = "ocid1.virtualcircuit.oc1.example.virtualcircuit_id"
}

  