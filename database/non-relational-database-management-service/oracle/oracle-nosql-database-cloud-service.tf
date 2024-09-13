
      # Configure o provedor do Oracle Cloud
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaz554q6q"
  # Substitua pelos valores corretos
}

# Crie um banco de dados NoSQL
resource "oci_nosql_table" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz554q6q"
  # Substitua pelo ID do compartimento
  name              = "example-table"
  table_type        = "KEY_VALUE"
  initial_capacity  = 1
  storage_size_in_gb = 10
}

# Crie um índice no banco de dados NoSQL
resource "oci_nosql_index" "example" {
  compartment_id = oci_nosql_table.example.compartment_id
  table_name      = oci_nosql_table.example.name
  index_name      = "example-index"
  index_type      = "HASH"
  key_path         = "["key"]"
}

# Crie um endpoint de acesso ao banco de dados NoSQL
resource "oci_nosql_endpoint" "example" {
  compartment_id = oci_nosql_table.example.compartment_id
  table_name      = oci_nosql_table.example.name
  endpoint_type   = "READ_WRITE"
  is_public       = false
}
    