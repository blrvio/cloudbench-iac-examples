
      # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaw747b7c"
  user    = "ocid1.user.oc1..aaaaaaaasf3y4q5"
  fingerprint = "xxxxxxxxxxxxxxxxxxxxx"
}

# Define the database VM
resource "oci_database_vm_db_system" "example" {
  availability_domain = "AD-1"
  compartment_id       = "ocid1.compartment.oc1..aaaaaaaau56z7j5"
  db_system_name      = "example-db-system"
  db_version           = "19.0.0.0.0"
  edition             = "ENTERPRISE_EDITION"
  shape               = "VM.Standard2.1"
  admin_password      = "password"
  # (Suppressed) other optional fields
}

# (Suppressed) other resources or configurations
    