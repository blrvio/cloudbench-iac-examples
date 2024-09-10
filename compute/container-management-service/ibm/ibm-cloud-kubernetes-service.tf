
    # Configure the IBM Cloud Provider
provider "ibm" {
  region = "us-south"
  # Add your IBM Cloud API Key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Kubernetes Cluster
resource "ibm_container_cluster" "main" {
  name = "my-kubernetes-cluster"
  # Choose the appropriate worker node type
  worker_node_type = "bx2-1x16"
  # Add cluster resource settings
  resource_group = "my-resource-group"
  location = "us-south"
}

# Create a Kubernetes Namespace
resource "ibm_container_namespace" "main" {
  name = "my-namespace"
  cluster_id = ibm_container_cluster.main.id
  # Add additional namespace settings
  #  resource_group = "my-resource-group"
  #  location = "us-south"
}

# Deploy a simple Nginx Deployment
resource "ibm_container_deployment" "nginx" {
  name = "nginx-deployment"
  cluster_id = ibm_container_cluster.main.id
  namespace = ibm_container_namespace.main.name
  # Add details about the container
  container {
    name = "nginx"
    image = "nginx:latest"
  }
  # Set a minimum number of replicas for the deployment
  replicas = 2
}

# Create a Kubernetes Service
resource "ibm_container_service" "nginx" {
  name = "nginx-service"
  cluster_id = ibm_container_cluster.main.id
  namespace = ibm_container_namespace.main.name
  # Define the service type
  type = "LoadBalancer"
  # Define the ports
  port {
    name = "http"
    port = 80
    target_port = 80
  }
  # Link the service to the deployment
  selector = {
    app = "nginx"
  }
}

  