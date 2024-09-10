
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "your_ibm_cloud_api_key"
  region  = "us-south"
}

# Create an IBM Graph Service
resource "ibm_graph_service" "main" {
  name     = "my-graph-service"
  location = "us-south"

  # Define the graph database type
  graph_type = "neo4j"
  # Define the service plan
  plan = "lite"

  # Optional: Define service instance tags
  tags = {
    environment = "dev"
  }
}

# Create an IBM Cloud Database User
resource "ibm_cloud_database_user" "main" {
  service_name = ibm_graph_service.main.name
  username     = "my-graph-user"
  password     = "my-graph-password"
  # Optional: Define user roles
  roles = ["read", "write"]
}

# Create an IBM Cloud Database Endpoint
resource "ibm_cloud_database_endpoint" "main" {
  service_name = ibm_graph_service.main.name
  # Optional: Define the endpoint type
  type = "public"
}

  