
      # Configure o provedor IBM Cloud
provider "ibm" {
  region  = "us-south"
  account_id = "xxxxxxxx"
  api_key    = "xxxxxxxxxxxxxxxxxxxxxxxx"
}

# Crie um cluster Kubernetes
resource "ibm_container_cluster" "my_cluster" {
  name      = "my-cluster"
  location = "us-south"
  version   = "1.23.x-default"
  worker_pool {
    size = 2
    flavor = "bx2.16x64"
  }
  addons {
    istio {
      enabled = true
    }
  }
}

# Crie um namespace no cluster
resource "ibm_container_namespace" "my_namespace" {
  cluster_id = ibm_container_cluster.my_cluster.id
  name       = "my-namespace"
}

# Importe o aplicativo para o cluster
resource "ibm_container_deployment" "my_deployment" {
  cluster_id  = ibm_container_cluster.my_cluster.id
  namespace   = ibm_container_namespace.my_namespace.name
  image       = "my-image:latest"
  replicas    = 2
  name        = "my-deployment"
}

    