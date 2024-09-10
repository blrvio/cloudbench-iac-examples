
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region = "us-south"
}

# Create a Compose for JanusGraph service
resource "ibm_compose_janusgraph_service" "main" {
  name     = "my-janusgraph-service"
  plan     = "standard"
  location = "us-south"
  # Add tags to the service
  tags = {
    Name = "My JanusGraph Service"
  }
}

# Create a Compose for JanusGraph instance
resource "ibm_compose_janusgraph_instance" "main" {
  name     = "my-janusgraph-instance"
  service_id = ibm_compose_janusgraph_service.main.id
  # Define the instance plan
  plan     = "standard"
  # Add tags to the instance
  tags = {
    Name = "My JanusGraph Instance"
  }
}

# Output the connection details
output "connection_details" {
  value = ibm_compose_janusgraph_instance.main.connection_details
}

  