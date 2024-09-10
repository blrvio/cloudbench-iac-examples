
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..."
  user    = "ocid1.user.oc1..."
  fingerprint = "..."
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Create an Autonomous JSON Database
resource "oci_database_autonomous_database" "example" {
  admin_password   = "MySecurePassword"
  availability_domain = "AD-1"
  compartment_id   = "ocid1.compartment.oc1..."
  cpu_core_count = 1
  db_name          = "my_json_db"
  db_version       = "19.0"
  license_model      = "LICENSE_INCLUDED"
  name              = "my-autonomous-json-database"
  shape             = "VM.Standard.E2.1"
  subnet_id         = "ocid1.subnet.oc1..."
  wait_for_state = "AVAILABLE"
}

# Create a user for the database
resource "oci_database_db_user" "example" {
  admin_password = "MySecurePassword"
  compartment_id = "ocid1.compartment.oc1..."
  db_name         = oci_database_autonomous_database.example.db_name
  name            = "my_json_user"
  password        = "MySecurePassword"
}

  