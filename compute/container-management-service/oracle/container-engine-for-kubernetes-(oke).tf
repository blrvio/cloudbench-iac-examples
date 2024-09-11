
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your region
}

# Create a Kubernetes cluster
resource "oci_core_cluster" "main" {
  # Set the cluster name
  name = "my-oke-cluster"
  # Choose a compartment to create the cluster in
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxx"
  # Specify the cluster's version
  kubernetes_version = "1.20.10"
  # Define the cluster's size
  node_shape = "VM.Standard.E2.1.Micro"
  # Choose the cluster's subnet
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaxxxxxxxxxx"

  # Optional settings
  # Specify a custom domain for the cluster
  # domain = "my-domain.com"
  # Set the cluster's maximum number of nodes
  # max_nodes = 5
  # Add a label to the cluster
  # labels = {
  #   "environment" = "development"
  # }
}

# Create a namespace within the Kubernetes cluster
resource "kubernetes_namespace" "main" {
  metadata {
    name = "my-namespace"
  }
  # Optional settings
  # labels = {
  #   "app" = "my-app"
  # }
}

# Create a deployment within the namespace
resource "kubernetes_deployment" "main" {
  metadata {
    name = "my-deployment"
    namespace = kubernetes_namespace.main.metadata.name
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        "app" = "my-app"
      }
    }
    template {
      metadata {
        labels = {
          "app" = "my-app"
        }
      }
      spec {
        containers {
          name = "my-app"
          image = "nginx:latest"
          # Add ports to the container
          ports {
            container_port = 80
          }
        }
      }
    }
  }
}

# Create a service to expose the deployment
resource "kubernetes_service" "main" {
  metadata {
    name = "my-service"
    namespace = kubernetes_namespace.main.metadata.name
  }
  spec {
    selector = {
      "app" = "my-app"
    }
    ports {
      port = 80
      target_port = 80
      protocol = "TCP"
    }
  }
}

  