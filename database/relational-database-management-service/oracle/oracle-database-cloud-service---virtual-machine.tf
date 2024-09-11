
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaat9w745a"
  user    = "ocid1.user.oc1..aaaaaaaam9g355g"
  key     = "your-api-key"
}

# Create a database system
resource "oci_database_system" "example" {
  admin_password = "your-password"
  availability_domain = "AD-1"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaav5p763w"
  db_name = "my-database"
  db_version = "19.17"
  display_name = "My Database System"
  is_admin_password_set = true
  shape_name = "VM.Standard.2"
  source = "NEW"
  subnet_id = "ocid1.subnet.oc1..aaaaaaaax9785r5"
}

# Create a database user
resource "oci_database_user" "example" {
  admin_password = "your-password"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaav5p763w"
  database_id = oci_database_system.example.id
  display_name = "My Database User"
  is_admin_password_set = true
  password = "your-password"
}

  