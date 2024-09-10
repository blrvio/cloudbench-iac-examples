
    # Configure the IBM Cloud provider
provider "ibm" {
  ibmcloud_api_key = "your_ibmcloud_api_key"
  region = "us-south"
}

# Create a Code Engine service
resource "ibm_codeengine_service" "main" {
  name = "my-codeengine-service"
  location = "us-south"
  runtime = "nodejs-16"

  # Define the container image to use
  image = "my-docker-hub-image:latest"

  # Set the number of replicas
  replicas = 2
}

# Create a Code Engine route
resource "ibm_codeengine_route" "main" {
  service_name = ibm_codeengine_service.main.name
  route_name = "my-route"

  # Configure the route rules
  rules {
    host = "my-codeengine-service.example.com"
    path = "/"
  }
}

# Create a Code Engine secret
resource "ibm_codeengine_secret" "main" {
  name = "my-secret"
  service_name = ibm_codeengine_service.main.name
  secret_type = "kubernetes"
  data = "your-secret-data"
}
  