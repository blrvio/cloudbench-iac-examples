
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
  # Credentials can be set through environment variables or a shared credentials file
  # Refer to the official Terraform documentation for detailed instructions
}

# Create a Kubernetes Cluster
resource "alicloud_cs_cluster" "main" {
  name = "my-kubernetes-cluster"
  # Choose the Kubernetes version
  kubernetes_version = "1.20"
  # Configure the worker node settings
  worker_nodes {
    # Specify the worker node type
    node_type = "ecs.c6.large"
    # Define the desired number of worker nodes
    count = 2
  }
  # Configure the network settings
  vpc_id = "vpc-xxxxx" # Replace with your VPC ID
  vswitch_id = "vswitch-xxxxx" # Replace with your VSwitch ID
  # Define the cluster configuration
  # You can adjust these settings according to your requirements
  cluster_config {
    # Optional configuration
    # Enable access to the Kubernetes API server
    #  enable_api_server_public_access = true
    # Define the security group for the cluster
    #  security_group_id = "sg-xxxxx"
  }
}

# Create a Namespace
resource "alicloud_cs_namespace" "main" {
  name = "my-namespace"
  cluster_id = alicloud_cs_cluster.main.id
}

# Deploy a Sample Application
# You can use the 'kubectl' command line tool or a deployment YAML file
# for deploying applications to the Kubernetes cluster
# Example deployment YAML:
# ---
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: nginx-deployment
#   namespace: my-namespace
# spec:
#   replicas: 3
#   selector:
#     matchLabels:
#       app: nginx
#   template:
#     metadata:
#       labels:
#         app: nginx
#     spec:
#       containers:
#       - name: nginx
#         image: nginx:1.14.2
#         ports:
#         - containerPort: 80

  