
    # Configure the IBM Cloud Provider
provider "ibm" {
  region = "us-south"
}

# Create a Compose for MySQL service instance
resource "ibm_compose_service" "main" {
  name     = "my-compose-for-mysql"
  plan     = "shared-2x"
  location = "us-south"
  tags     = {
    environment = "dev"
  }
}

# Create a Compose for MySQL database
resource "ibm_compose_database" "main" {
  service_id = ibm_compose_service.main.id
  name       = "my-database"
}

# Create a Compose for MySQL user
resource "ibm_compose_user" "main" {
  service_id = ibm_compose_service.main.id
  name       = "my-user"
  password   = "my-password"
}

# Grant the user access to the database
resource "ibm_compose_user_database" "main" {
  service_id   = ibm_compose_service.main.id
  user_name   = ibm_compose_user.main.name
  database_name = ibm_compose_database.main.name
  permissions = "readwrite"
}

  