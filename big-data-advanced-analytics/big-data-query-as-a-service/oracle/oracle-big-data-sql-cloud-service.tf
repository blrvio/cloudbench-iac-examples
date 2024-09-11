
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaazg537z64"
  user    = "ocid1.user.oc1..aaaaaaaaw3m66z5v"
  fingerprint = "xxxxx"
  key_file = "~/.oci/config"
}

# Create a Big Data SQL database
resource "oci_database_bigdatasql_database" "main" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaajg547254"
  display_name = "my-bigdata-sql-database"
  edition        = "ENTERPRISE"
  shape          = "BD_SQL_XS"
  is_auto_scaling_enabled = false
  # Define the storage settings for the database
  storage_config {
    storage_size_in_gbs = 100
  }
  # Define the network configuration for the database
  network_config {
    subnet_id = "ocid1.subnet.oc1..aaaaaaaax5m746zm"
  }
}

# Create a Big Data SQL user
resource "oci_database_bigdatasql_user" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaajg547254"
  database_id  = oci_database_bigdatasql_database.main.id
  display_name = "my-bigdata-sql-user"
  # Define the password for the user
  password = "my-password"
}

# Create a Big Data SQL schema
resource "oci_database_bigdatasql_schema" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaajg547254"
  database_id  = oci_database_bigdatasql_database.main.id
  display_name = "my-bigdata-sql-schema"
  # Define the user that owns the schema
  owner_id = oci_database_bigdatasql_user.main.id
}

  