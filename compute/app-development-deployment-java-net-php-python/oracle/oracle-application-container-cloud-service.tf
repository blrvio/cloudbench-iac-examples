
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your desired region
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  private_key_path = "~/.oci/oci_api_key.pem" # Path to your private key
}

# Create an Application Container Cloud Service
resource "oci_containerengine_cluster" "main" {
  name = "my-container-cluster"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Define the Kubernetes version
  kubernetes_version = "1.20.11"
  # Set the size and shape of the cluster nodes
  node_config {
    size = "VM.Standard.A1.Flex"
  }
  # Define the service discovery configuration
  service_discovery_config {
    type = "ONS"
    # Configure the ONS service discovery settings
    ons {
      # Enable or disable service discovery
      enabled = true
    }
  }
}

# Create an Application Container Cloud Service Namespace
resource "oci_containerengine_namespace" "main" {
  cluster_id = oci_containerengine_cluster.main.id
  name = "my-namespace"
}

# Create an Application Container Cloud Service Deployment
resource "oci_containerengine_deployment" "main" {
  namespace_id = oci_containerengine_namespace.main.id
  name = "my-deployment"
  # Define the Docker image to be deployed
  image_config {
    image_uri = "docker.io/library/nginx:latest"
  }
  # Define the number of replicas for the deployment
  replicas = 3
  # Define the deployment strategy
  strategy {
    type = "RECREATE"
  }
  # Define the deployment resource requirements
  resource_requirements {
    limits {
      cpu = "1"
      memory = "1Gi"
    }
    requests {
      cpu = "0.5"
      memory = "512Mi"
    }
  }
}

  