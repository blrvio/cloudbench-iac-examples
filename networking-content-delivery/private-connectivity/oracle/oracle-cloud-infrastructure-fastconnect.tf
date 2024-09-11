
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..."
  user    = "ocid1.user.oc1..."
  key_file = "path/to/key/file"
}

# Create a FastConnect connection
resource "oci_core_fastconnect_connection" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  name          = "my-fastconnect-connection"
  bandwidth_shape = "100Mbps"
  # ... other configuration options
}

# Create a Virtual Circuit
resource "oci_core_fastconnect_virtual_circuit" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  name           = "my-virtual-circuit"
  connection_id = oci_core_fastconnect_connection.main.id
  # ... other configuration options
}

# Create a VLAN
resource "oci_core_virtual_circuit_vlan" "main" {
  compartment_id   = "ocid1.compartment.oc1..."
  virtual_circuit_id = oci_core_fastconnect_virtual_circuit.main.id
  vlan_tag         = 100
  # ... other configuration options
}

  