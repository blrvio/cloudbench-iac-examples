
    # Configure the Oracle Cloud provider
provider "oci" {
  # Replace with your Oracle Cloud credentials
  config_file = "~/.oci/config"
  profile = "default"
}

# Create a NoSQL Database Cloud Service table
resource "oci_nosql_table" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  table_name     = "my-nosql-table"
  key_schema = <<EOF
{"type": "struct", "fields": [
{"name": "id", "type": "string", "constraints": [{"type": "primaryKey"}]},
{"name": "name", "type": "string"}
]}
EOF

  # Optional: Define the index schema
  # index_schema = <<EOF
  # {"type": "index", "indexName": "nameIndex", "indexKeys": [{
  # "name": "name", "type": "string", "constraints": [{"type": "unique"}]
  # }]
  # }
  # EOF

  # Optional: Define the storage configuration
  # storage_configuration {
  #   capacity_unit = "1"
  #   storage_type   = "STANDARD"
  # }
}

# Create a NoSQL Database Cloud Service index
# resource "oci_nosql_index" "main" {
#  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
#  table_name     = oci_nosql_table.main.table_name
#  index_name     = "nameIndex"
#  index_keys = [{
#    name = "name"
#    type = "string"
#    # Optional: Define unique constraint for the index
#    # constraints = [{"type": "unique"}]
#  }]
#}

# Create a NoSQL Database Cloud Service user
resource "oci_nosql_user" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  user_name     = "my-nosql-user"
  # Optional: Define the password for the user
  # password      = "MyStrongPassword"
}

# Create a NoSQL Database Cloud Service table permission
# resource "oci_nosql_table_permission" "main" {
#  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
#  table_name     = oci_nosql_table.main.table_name
#  user_name     = oci_nosql_user.main.user_name
#  permission     = "READ"
#}

  