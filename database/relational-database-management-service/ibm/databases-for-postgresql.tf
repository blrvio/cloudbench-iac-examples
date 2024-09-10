
    # Configure the IBM Cloud Provider
provider "ibm" {
  api_key    = "your_api_key" # Replace with your IBM Cloud API key
  region = "us-south"
}

# Create a service instance for Databases for PostgreSQL
resource "ibm_service_instance" "postgresql" {
  name   = "my-postgresql-instance"
  plan   = "postgresql_trial"
  service = "databases-for-postgresql"
  location = "us-south"
  # You can add other optional parameters here, such as tags
}

# Create a PostgreSQL database
resource "ibm_postgresql_database" "main" {
  name    = "my-db"
  service_instance_id = ibm_service_instance.postgresql.id
  # You can add other optional parameters here, such as the encoding
}

# Create a user for the PostgreSQL database
resource "ibm_postgresql_user" "main" {
  name = "my-user"
  service_instance_id = ibm_service_instance.postgresql.id
  password = "my-password"
  # You can add other optional parameters here, such as roles
}

# Grant access to the database for the user
resource "ibm_postgresql_grant" "main" {
  user             = ibm_postgresql_user.main.name
  database         = ibm_postgresql_database.main.name
  service_instance_id = ibm_service_instance.postgresql.id
  # You can add other optional parameters here, such as roles
}
  