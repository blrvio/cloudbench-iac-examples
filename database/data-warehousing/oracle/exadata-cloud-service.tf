
    # Configure the Oracle provider
provider "oracle" {
  # Configure your Oracle Cloud credentials
  user = "your_username"
  password = "your_password"
  # Configure the tenancy
  tenancy = "your_tenancy"
}

# Create an Exadata Cloud Service instance
resource "oracle_exadata_cloud_service" "main" {
  # Configure the service details
  name = "my-exadata-service"
  # Configure the shape, which defines the resources available
  shape = "Exadata_X8M_2"
  # Specify the compartment to create the service in
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw777777777777777777777777777"
  # Enable or disable the service
  enabled = true
  # Configure the network details
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaw777777777777777777777777777"
  # Configure the storage details
  storage_size_in_tbs = 100
  # Configure the database details
  database_version = "19c"
  # Specify the number of nodes
  node_count = 2
}

# Create a database on the Exadata Cloud Service instance
resource "oracle_database" "main" {
  # Configure the database details
  name = "my-database"
  # Configure the connection details
  connection_string = "jdbc:oracle:thin:@//your_exadata_service_endpoint:1521/your_database_service_name"
  # Configure the database version
  version = "19c"
  # Specify the Exadata Cloud Service instance
  exadata_cloud_service_id = oracle_exadata_cloud_service.main.id
}

  