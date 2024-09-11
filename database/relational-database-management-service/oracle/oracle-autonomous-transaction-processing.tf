
    # Configure the Oracle provider
provider "oracle" {
  # Set the connection details for your Oracle Cloud Infrastructure (OCI)
  # You can find these in your OCI console
  # https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm
  # Ensure you've configured the 'OCI_CONFIG_FILE' environment variable
  # or set the 'config_file' and 'profile' values accordingly
}

# Create an Autonomous Transaction Processing database
resource "oci_database_autonomous_database" "main" {
  # Set a unique name for the database
  display_name = "my-atp-database"
  # Select the desired compartment ID from OCI
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Choose the appropriate database edition
  edition = "ENTERPRISE"
  # Specify the desired version of the database
  version = "19.0.0.0"
  # Set the desired size of the database
  db_size = 20
  # Set the desired number of CPU cores
  cpu_core_count = 2
  # Select the desired network subnet ID
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Configure the database with the appropriate security settings
  # For production environments, consider creating a dedicated subnet
  # and configure firewall rules accordingly
}

# Output the database connection string
output "database_connection_string" {
  value = oci_database_autonomous_database.main.connection_string
}
  