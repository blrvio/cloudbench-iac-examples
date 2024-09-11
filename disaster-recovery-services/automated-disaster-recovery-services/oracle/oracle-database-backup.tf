
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud Infrastructure tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa"
}

# Create a database backup
resource "oci_database_backup" "main" {
  database_id = oci_database_database.example.id
  backup_type = "FULL"
  # Optionally specify a backup name
  display_name = "My Database Backup"
}

# Create a database
resource "oci_database_database" "example" {
  admin_password = "password"
  # Replace with your Oracle Cloud Infrastructure compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your Oracle Cloud Infrastructure subnet OCID
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your database version
  version        = "19c"
  # Replace with your database name
  db_name = "my-database"
  # Optionally specify a database display name
  display_name = "My Database"
}

  