
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region = "us-south"
}

# Create a container registry
resource "ibm_container_registry" "main" {
  name     = "my-registry"
  location = "us-south"
}

# Create a namespace within the registry
resource "ibm_container_registry_namespace" "main" {
  name       = "my-namespace"
  registry_id = ibm_container_registry.main.id
}

# Push an image to the registry
resource "ibm_container_registry_image" "main" {
  name = "my-image:latest"
  # This is the Docker image path, replace with your actual image
  # e.g. "docker.io/library/nginx:latest"
  source = "docker.io/library/nginx:latest"
  namespace = ibm_container_registry_namespace.main.name
  registry_id = ibm_container_registry.main.id
}

  