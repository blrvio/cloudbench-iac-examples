
    # Configure the IBM Cloud Provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create a Db2 Warehouse service
resource "ibm_db2w_service" "main" {
  name     = "my-db2w-service"
  plan     = "standard"
  location = "us-south"
  # Set the database configuration
  database_config {
    name        = "my-db2w-database"
    character_set = "UTF-8"
    collation = "UTF-8"
  }
}

# Create a Db2 Warehouse instance
resource "ibm_db2w_instance" "main" {
  service_name = ibm_db2w_service.main.id
  name         = "my-db2w-instance"
  # Define the instance size
  size = "small"
}

# Create a Db2 Warehouse user
resource "ibm_db2w_user" "main" {
  service_name = ibm_db2w_service.main.id
  name         = "my-db2w-user"
  password     = "my-db2w-password"
}

# Create a Db2 Warehouse schema
resource "ibm_db2w_schema" "main" {
  service_name = ibm_db2w_service.main.id
  database_name = ibm_db2w_service.main.database_config.0.name
  name         = "my-db2w-schema"
  # Set the schema owner
  owner = ibm_db2w_user.main.id
}

# Create a Db2 Warehouse table
resource "ibm_db2w_table" "main" {
  service_name = ibm_db2w_service.main.id
  database_name = ibm_db2w_service.main.database_config.0.name
  schema_name  = ibm_db2w_schema.main.name
  name         = "my-db2w-table"
  # Define the table columns
  columns {
    name   = "id"
    type   = "INT"
    length = 4
  }
  columns {
    name   = "name"
    type   = "VARCHAR"
    length = 255
  }
}

  