
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud Infrastructure tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxx"
}

# Create a NoSQL database
resource "oci_nosql_database" "main" {
  # The compartment where you want to create the database
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Unique identifier of the NoSQL database
  database_name = "my-nosql-database"
  # The NoSQL database version
  version = "2.2.1"
  # Enable or disable encryption at rest
  is_encryption_at_rest_enabled = true
  # The NoSQL database security group
  security_list_id = "ocid1.securitylist.oc1..aaaaaaaaxxxxxxxxxxxxxx"
}

# Create a NoSQL table
resource "oci_nosql_table" "main" {
  # The compartment where you want to create the table
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # The NoSQL database where you want to create the table
  database_id = oci_nosql_database.main.id
  # Unique identifier of the NoSQL table
  table_name = "my-nosql-table"
  # The NoSQL table key schema
  key_schema = <<EOF
{"name": "id", "type": "STRING", "is_primary_key": true}
EOF
}

  