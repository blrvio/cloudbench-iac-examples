
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"  # Replace with your IBM Cloud API key
  region  = "us-south" # Replace with your desired region
}

# Create a Hyper Protect DBaaS for PostgreSQL service instance
resource "ibm_hyper_protect_dbas_postgresql" "main" {
  name = "my-postgresql-instance"
  # Add optional configuration, such as:
  # - plan:
  # - version:
  # - service_plan:
}

# Create a database within the PostgreSQL service instance
resource "ibm_hyper_protect_dbas_postgresql_database" "main" {
  hyper_protect_dbas_postgresql_id = ibm_hyper_protect_dbas_postgresql.main.id
  name = "my-database"
}

# Create a user for the PostgreSQL service instance
resource "ibm_hyper_protect_dbas_postgresql_user" "main" {
  hyper_protect_dbas_postgresql_id = ibm_hyper_protect_dbas_postgresql.main.id
  name = "my-user"
  password = "my-password" # Replace with a strong password
}

# Grant privileges to the user for the database
resource "ibm_hyper_protect_dbas_postgresql_user_grant" "main" {
  hyper_protect_dbas_postgresql_id = ibm_hyper_protect_dbas_postgresql.main.id
  user_name = ibm_hyper_protect_dbas_postgresql_user.main.name
  database_name = ibm_hyper_protect_dbas_postgresql_database.main.name
  # Grant specific privileges, such as:
  # - all_privileges = true
  # - privileges = ["CONNECT", "TEMPORARY", "USAGE"]
}

  