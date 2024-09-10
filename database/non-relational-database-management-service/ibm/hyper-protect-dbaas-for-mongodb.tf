
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_API_KEY"
  region  = "us-south"
}

# Create a MongoDB service instance
resource "ibm_mongodb_service" "main" {
  name           = "my-mongodb-service"
  plan           = "shared"
  resource_group = "my-resource-group"
}

# Create a MongoDB database
resource "ibm_mongodb_database" "main" {
  service_id  = ibm_mongodb_service.main.id
  name        = "my-database"
}

# Create a MongoDB user
resource "ibm_mongodb_user" "main" {
  service_id = ibm_mongodb_service.main.id
  database   = ibm_mongodb_database.main.name
  username   = "my-user"
  password   = "my-password"
}
  