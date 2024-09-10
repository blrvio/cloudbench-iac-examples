
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
}

# Create an IBM Cloud Kubernetes Service cluster
resource "ibm_container_cluster" "main" {
  name         = "my-openshift-cluster"
  location     = "us-south"
  worker_count = 3
  # Choose the Openshift version
  version = "4.10"
  # Select the worker machine type
  worker_machine_type = "bx2.16x32"
  # Add a service account to the cluster
  service_account {
    name = "my-service-account"
  }
}

# Create a namespace for your applications
resource "ibm_container_namespace" "main" {
  cluster_id = ibm_container_cluster.main.id
  name       = "my-namespace"
}

# Create a deployment of your application
resource "ibm_container_deployment" "main" {
  cluster_id    = ibm_container_cluster.main.id
  namespace_id = ibm_container_namespace.main.id
  name          = "my-application"
  image         = "nginx:latest"
  # Configure the replica count
  replicas = 3
}

  