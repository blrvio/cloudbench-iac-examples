
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region = "us-south"
  api_key = "YOUR_API_KEY"
}

# Create a MongoDB instance
resource "ibm_cloud_databases_for_mongodb" "main" {
  name = "my-mongodb-instance"
  service_plan = "standard-2"
  cluster_type = "shared"
  region = "us-south"
  # Configure optional settings for the instance
  # For example, you can set up authentication, backup settings, and more
  # See the IBM Cloud documentation for more details
  # https://cloud.ibm.com/docs/databases-for-mongodb?topic=databases-for-mongodb-getting-started
}

# Create a user for the MongoDB instance
resource "ibm_cloud_databases_for_mongodb_user" "main" {
  database = ibm_cloud_databases_for_mongodb.main.name
  username = "my-mongodb-user"
  password = "my-password"
  # Optional settings for the user
  # See the IBM Cloud documentation for more details
  # https://cloud.ibm.com/docs/databases-for-mongodb?topic=databases-for-mongodb-getting-started
}

  