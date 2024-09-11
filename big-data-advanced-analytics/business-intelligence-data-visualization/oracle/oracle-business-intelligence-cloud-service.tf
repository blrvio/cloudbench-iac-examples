
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your Oracle Cloud region
  # Configure authentication details (e.g., API Key or Instance Principal)
}

# Create an Oracle Business Intelligence Cloud Service instance
resource "oci_bi_instance" "main" {
  display_name = "my-bi-instance"
  # Specify the compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Define the edition and tier
  edition = "Enterprise"
  tier = "Standard"
  # Configure other options as needed
}

# Create a user for the Business Intelligence Cloud Service instance
resource "oci_bi_user" "main" {
  display_name = "my-bi-user"
  instance_id = oci_bi_instance.main.id
  # Define the user's role
  role = "administrator"
  # Configure other options as needed
}

# Create a data source connection to a database
resource "oci_bi_datasource_connection" "main" {
  display_name = "my-datasource-connection"
  instance_id = oci_bi_instance.main.id
  # Define the database connection details
  database_type = "Oracle Database"
  host = "my-database.example.com"
  port = 1521
  service_name = "my-database"
  # Define the authentication credentials
  username = "my-database-user"
  password = "my-database-password"
}

# Create a data source for the Business Intelligence Cloud Service instance
resource "oci_bi_datasource" "main" {
  display_name = "my-datasource"
  instance_id = oci_bi_instance.main.id
  # Define the connection for the data source
  connection_id = oci_bi_datasource_connection.main.id
  # Configure other options as needed
}

  