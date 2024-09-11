
    # Configure the provider for Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud Infrastructure tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..."
  # Replace with your Oracle Cloud Infrastructure user OCID
  user_ocid = "ocid1.user.oc1..."
  # Replace with your Oracle Cloud Infrastructure API key
  api_key = "..."
}

# Create a Database
resource "oci_database_database" "main" {
  # Replace with a valid compartment OCID
  compartment_id = "ocid1.compartment.oc1..."
  # Database name
  display_name = "graph-db"
  # Choose your database edition
  edition = "ENTERPRISE_EDITION"
  # Choose your database version
  version = "19c"
  # Define the database character set
  character_set = "AL32UTF8"
  # Define the national character set
  national_character_set = "AL16UTF16"
  # Define the database's shape
  shape_name = "VM.Standard.E2.1"
  # Choose your network configuration
  # Replace with a valid subnet OCID
  subnet_id = "ocid1.subnet.oc1..."
  # Define the database's connection string
  # Replace with a valid private IP address
  private_endpoint_ip = "10.0.0.4"
}

# Create a Graph Database Instance
resource "oci_database_graph_database" "main" {
  # Replace with the Database's OCID
  database_id = oci_database_database.main.id
  # Define the Graph Database's name
  display_name = "graph-instance"
  # Specify the Graph Database's version
  version = "2.0"
  # Define the Graph Database's size
  size_in_gbs = 100
}

  