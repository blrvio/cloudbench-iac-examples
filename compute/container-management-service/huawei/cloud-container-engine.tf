
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a CCE cluster
resource "huaweicloud_cce_cluster" "main" {
  name        = "my-cce-cluster"
  version     = "v1.18.15"
  node_pool {
    name       = "default-node-pool"
    node_count = 2
    node_type   = "cce.s2.small"
    # Add more node pools as needed
  }
  # Define the network configuration for the cluster
  network_config {
    vpc_id    = "your-vpc-id"
    subnet_id = "your-subnet-id"
  }
}

# Create a namespace
resource "huaweicloud_cce_namespace" "main" {
  name     = "my-namespace"
  cluster_id = huaweicloud_cce_cluster.main.id
}

# Deploy a container application
resource "huaweicloud_cce_deployment" "main" {
  name       = "my-deployment"
  namespace = huaweicloud_cce_namespace.main.name
  image      = "nginx:latest"
  replicas = 2
}

  