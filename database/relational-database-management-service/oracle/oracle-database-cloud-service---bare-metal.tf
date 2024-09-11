
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  user    = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa"
  key     = "<YOUR_API_KEY>"
}

# Create a Virtual Cloud Network (VCN)
resource "oci_core_vcn" "main" {
  cidr_block = "10.0.0.0/16"
  display_name = "My VCN"
}

# Create a subnet within the VCN
resource "oci_core_subnet" "main" {
  vcn_id       = oci_core_vcn.main.id
  cidr_block    = "10.0.1.0/24"
  display_name = "My Subnet"
}

# Create a database instance
resource "oci_database_db_system" "main" {
  availability_domain = "AD-1"
  admin_password     = "<YOUR_PASSWORD>"
  db_home           = "<YOUR_DB_HOME_PATH>"
  db_version         = "19.0.0.0.0"
  shape             = "BM.Standard.E2.2"
  subnet_id          = oci_core_subnet.main.id
  # Create a database user
  admin_user         = "<YOUR_USERNAME>"
  display_name       = "My Database"
}

# Create a database user
resource "oci_database_db_user" "main" {
  admin_password     = "<YOUR_PASSWORD>"
  db_home           = "<YOUR_DB_HOME_PATH>"
  db_system_id       = oci_database_db_system.main.id
  display_name       = "My Database User"
  username           = "<YOUR_USERNAME>"
}

# Create a database schema
resource "oci_database_db_schema" "main" {
  db_home           = "<YOUR_DB_HOME_PATH>"
  db_system_id       = oci_database_db_system.main.id
  display_name       = "My Database Schema"
  username           = "<YOUR_USERNAME>"
}
  