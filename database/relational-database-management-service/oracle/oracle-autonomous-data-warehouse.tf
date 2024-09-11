
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your desired region
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaagzn56kja7b6h5x7y5y2j37462w57a2h"
  user_ocid = "ocid1.user.oc1..aaaaaaaagxzz6p3t4z5r2434x4h456434x67a3n"
  fingerprint = "<fingerprint>"
  # Set the compartment OCID for your resources
  compartment_id = "ocid1.compartment.oc1..aaaaaaaagz7a3g455r5y3t3x547543x6y5a2a"
}

# Create an Autonomous Data Warehouse
resource "oci_database_autonomous_database" "main" {
  display_name = "my-autonomous-database"
  # Choose a database edition
  edition = "ENTERPRISE_EDITION"
  # Select a database version
  database_version = "19.0.0.0.0"
  # Select a compute shape
  compute_shape = "VM.Standard.E4.Flex"
  # Choose a storage size
  data_storage_size_in_tbs = 100
  # Select a network configuration
  subnet_id = "ocid1.subnet.oc1..aaaaaaaagz7a3g455r5y3t3x547543x6y5a2a"
  # Add a free-form tag to the database
  freeform_tags = {
    "Created by" = "Terraform"
  }
  # Configure the database backups
  backup_config {
    # Define the backup retention policy
    retention_policy = "DAILY"
    backup_retention_duration = 7 # Days
  }
}

# Create a database user
resource "oci_database_user" "main" {
  database_id = oci_database_autonomous_database.main.id
  username  = "my_user"
  # Set the user password
  password = "MyP@sswOrd1"
  # Define the user's default role
  default_role = "DBA"
}

# Create a database schema
resource "oci_database_schema" "main" {
  database_id = oci_database_autonomous_database.main.id
  schema_name = "my_schema"
}

  