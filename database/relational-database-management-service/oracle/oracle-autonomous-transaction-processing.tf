
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
}

# Create an Autonomous Transaction Processing database
resource "oci_database_autonomous_database" "main" {
  # Database name
  display_name = "my-autonomous-db"
  # Database edition
  edition = "ENTERPRISE"
  # Database version
  version = "19c"
  # Database storage size
  storage_size_in_tbs = 100
  # Database subnet ID
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaxxxxxx"
  # Database network access type
  network_access_type = "PRIVATE"
  # Database connection string
  connection_string = "example.com:1521/example"
  # Database user credentials
  # Remove the following lines if you're using a different authentication method
  #admin_username = "admin"
  #admin_password = "password"
}

# Create a database user
resource "oci_database_user" "main" {
  # Database user name
  username = "my-user"
  # Database user password
  password = "password"
  # Database ID
  autonomous_database_id = oci_database_autonomous_database.main.id
}

# Create a database schema
resource "oci_database_schema" "main" {
  # Database schema name
  schema_name = "my-schema"
  # Database user ID
  user_id = oci_database_user.main.id
}

  