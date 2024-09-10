
    # Configure the IBM Cloud Provider
provider "ibm" {
  # Replace with your IBM Cloud API key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  # Replace with your IBM Cloud region
  region = "us-south"
}

# Create a Mass Data Migration Service instance
resource "ibm_mass_data_migration_instance" "main" {
  # Replace with your instance name
  name = "my-mass-data-migration-instance"
  # Replace with your resource group
  resource_group_id = "YOUR_RESOURCE_GROUP_ID"
  # Replace with your VPC ID
  vpc_id = "YOUR_VPC_ID"
}

# Create a Mass Data Migration Service connection
resource "ibm_mass_data_migration_connection" "main" {
  # Replace with your connection name
  name = "my-mass-data-migration-connection"
  # Replace with the instance ID
  instance_id = ibm_mass_data_migration_instance.main.id
  # Replace with your database type
  database_type = "mysql"
  # Replace with your host
  host = "YOUR_HOST"
  # Replace with your port
  port = "YOUR_PORT"
  # Replace with your username
  username = "YOUR_USERNAME"
  # Replace with your password
  password = "YOUR_PASSWORD"
}

# Create a Mass Data Migration Service migration
resource "ibm_mass_data_migration_migration" "main" {
  # Replace with your migration name
  name = "my-mass-data-migration-migration"
  # Replace with the connection ID
  connection_id = ibm_mass_data_migration_connection.main.id
  # Replace with your source schema
  source_schema = "YOUR_SOURCE_SCHEMA"
  # Replace with your target schema
  target_schema = "YOUR_TARGET_SCHEMA"
  # Replace with your migration type
  migration_type = "full"
}

  