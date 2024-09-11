
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Set the region and tenancy OCID
  region = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1…"
}

# Create an Autonomous JSON Database
resource "oci_database_autonomous_database" "main" {
  # Specify a unique name for the database
  display_name = "example-json-database"
  # Choose the desired database edition
  edition         = "ENTERPRISE_EDITION"
  # Select the desired database version
  database_version = "19.0.0.0.0"
  # Choose the desired shape
  db_shape = "VM.Standard.E2.1"
  # Specify the compartment OCID
  compartment_id = "ocid1.compartment.oc1…"
  # Configure the database network
  # Select the desired subnet OCID
  subnet_id = "ocid1.subnet.oc1…"
  # Configure the database access
  # Specify the desired admin user
  admin_user = "admin"
  # Configure the database security
  # Specify the desired security policy OCID
  security_policy_id = "ocid1.securitypolicy.oc1…"
  # Specify the desired encryption key OCID
  encryption_key_id = "ocid1.enckey.oc1…"
  # Configure the database maintenance
  # Specify the desired maintenance window
  maintenance_window = "2023-04-10T08:00:00Z/2023-04-10T10:00:00Z"
}

  