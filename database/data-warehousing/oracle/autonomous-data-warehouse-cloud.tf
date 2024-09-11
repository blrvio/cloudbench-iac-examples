
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Use your Oracle Cloud Infrastructure tenancy details
  tenancy_id   = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxx"
  user_ocid    = "ocid1.user.oc1..aaaaaaaaxxxxxxxxx"
  fingerprint  = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  private_key  = "~/.ssh/id_rsa"
}

# Create an Autonomous Data Warehouse (ADW)
resource "oci_datawarehousing_autonomous_database" "main" {
  # Set ADW parameters
  admin_password       = "MyStrongPassword123!" # Use a strong password
  compartment_id       = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
  database_edition    = "ENTERPRISE_EDITION"
  database_name        = "my-adw-db"
  db_version           = "19.0.0.0.0"
  display_name         = "My ADW"
  license_model        = "LICENSE_INCLUDED"
  network_subnet_id    = "ocid1.subnet.oc1..aaaaaaaaxxxxxxxxx"
  source_details_type = "NONE"
  storage_size_in_tbs = 100
  # Use the default database (no change needed)
  data_safe_enabled  = false
}

# Create an Autonomous Data Warehouse User
resource "oci_datawarehousing_autonomous_database_user" "main" {
  admin_password   = "MyStrongPassword123!" # Use a strong password
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
  database_name     = oci_datawarehousing_autonomous_database.main.database_name
  display_name      = "MyADWUser"
  is_admin          = false # Optional for admin privileges
  # Set the password for the user
  password           = "MyStrongPassword123!" # Use a strong password
  user_name         = "myadwuser"
}

# Create an Autonomous Data Warehouse Wallet
resource "oci_datawarehousing_autonomous_database_wallet" "main" {
  autonomous_database_id = oci_datawarehousing_autonomous_database.main.id
  compartment_id         = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
  display_name           = "MyADWWallet"
}

# Optional: Create an Autonomous Data Warehouse Data Safe
# resource "oci_datawarehousing_autonomous_database_data_safe" "main" {
#   autonomous_database_id = oci_datawarehousing_autonomous_database.main.id
#   compartment_id         = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
#   display_name           = "MyADWDataSafe"
#   state                 = "ENABLED"
# }

  