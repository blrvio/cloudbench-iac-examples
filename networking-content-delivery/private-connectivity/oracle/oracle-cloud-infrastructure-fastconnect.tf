
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1"
  # Substitua pela sua região desejada
}

# Crie um FastConnect
resource "oci_core_fast_connect" "example" {
  # Substitua pelos valores reais
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7777777777777777777777777777"
  display_name  = "FastConnectExample"
  # ...
}

# Crie uma conexão FastConnect
resource "oci_core_fast_connect_connection" "example" {
  # Substitua pelos valores reais
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7777777777777777777777777777"
  display_name  = "FastConnectConnectionExample"
  fast_connect_id  = oci_core_fast_connect.example.id
  # ...
}
    