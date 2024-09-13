
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1" # Substitua pela sua região desejada
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaz53hdx7g"
}

# Crie uma rede virtual
resource "oci_core_vcn" "main_vcn" {
  cidr_block       = "10.0.0.0/16"
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaz53hdx7g"
  display_name     = "Main VCN"
}

# Crie um subnet
resource "oci_core_subnet" "subnet_1" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaz53hdx7g"
  vcn_id          = oci_core_vcn.main_vcn.id
  cidr_block       = "10.0.1.0/24"
  display_name     = "Subnet 1"
}

# Crie uma tabela de rotas
resource "oci_core_route_table" "main_route_table" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaz53hdx7g"
  vcn_id          = oci_core_vcn.main_vcn.id
  display_name     = "Main Route Table"
}

# Crie uma regra de rota
resource "oci_core_route_rule" "default_route_rule" {
  route_table_id  = oci_core_route_table.main_route_table.id
  network_entity_id = oci_core_vcn.main_vcn.id
  destination      = "0.0.0.0/0"
  destination_type = "CIDR_BLOCK"
  is_default       = true
}
    