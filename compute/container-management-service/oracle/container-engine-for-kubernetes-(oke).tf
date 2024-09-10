
    # Configure the Oracle Cloud Provider
provider "oci" {
  region = "us-ashburn-1"
  # Use your OCI tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaay3h3n7a"
}

# Create an OKE cluster
resource "oci_core_cluster" "main" {
  availability_domain = "us-ashburn-1a"
  # Choose a supported Kubernetes version
  kubernetes_version = "1.24.14"
  name = "my-oke-cluster"
  # Choose a Kubernetes flavor
  shape = "VM.Standard.E2.1"
  
  # Optional: Define a node pool
  node_pool {
    name = "default-node-pool"
    # Choose a node shape
    shape = "VM.Standard.E2.1"
  }
}

# Create a namespace for your applications
resource "oci_kubernetes_namespace" "main" {
  cluster_id = oci_core_cluster.main.id
  display_name = "my-namespace"
}

# Deploy an application using a Kubernetes Deployment
resource "oci_kubernetes_deployment" "main" {
  cluster_id = oci_core_cluster.main.id
  # Choose a namespace
  namespace = oci_kubernetes_namespace.main.id
  # Provide a deployment name
  name = "my-deployment"
  # Define the number of replicas
  replicas = 3
  # Define a container within the deployment
  container {
    image = "nginx:latest"
    # Define the port mapping
    port {
      container_port = 80
    }
  }
}

# Create a Kubernetes Service for exposing your application
resource "oci_kubernetes_service" "main" {
  cluster_id = oci_core_cluster.main.id
  # Choose a namespace
  namespace = oci_kubernetes_namespace.main.id
  name = "my-service"
  # Define the service type
  service_type = "LoadBalancer"
  # Define the port mapping
  port {
    target_port = 80
  }
  # Define the selector for the service
  selector = {
    "app" = "my-deployment"
  }
}

  