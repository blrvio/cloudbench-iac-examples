
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxx"
  user    = "ocid1.user.oc1..aaaaaaaaxxxxxxxxx"
  fingerprint = "xxxxxxxxxxxxxxxx"
  private_key = "<your_private_key>"
}

# Create an Application Container Cloud Service
resource "oci_containerengine_cluster" "main" {
  display_name  = "my-container-cluster"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
  # Create a Kubernetes cluster
  kubernetes_config {
    version = "1.20.7"
  }
  # Configure the cluster network
  network_config {
    subnet_ids = ["ocid1.subnet.oc1..aaaaaaaaxxxxxxxxx"]
  }
  # Add a node pool
  node_pools {
    name          = "my-node-pool"
    size          = 2
    node_shape    = "VM.Standard.E2.1.Micro"
    node_image_id = "ocid1.image.oc1..aaaaaaaaxxxxxxxxx"
  }
}

# Deploy a container application
resource "oci_containerengine_manifest" "main" {
  display_name   = "my-container-app"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxx"
  cluster_id     = oci_containerengine_cluster.main.id
  # Define the container image
  image_details {
    image_uri = "docker.io/library/nginx:latest"
  }
  # Define the deployment configuration
  deploy_config {
    replicas = 2
  }
}

  