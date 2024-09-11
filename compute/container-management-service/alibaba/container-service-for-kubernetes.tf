
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud credentials
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
  region      = "cn-hangzhou"
}

# Create a Kubernetes Cluster
resource "alicloud_cs_cluster" "main" {
  name            = "my-kubernetes-cluster"
  # Choose your Kubernetes version
  kubernetes_version = "1.21.1"
  # Specify the node type for your cluster
  node_type = "ecs.c5.xlarge"
  # Set the number of nodes for your cluster
  node_count = 2

  # Define the VPC network settings
  vpc_id        = "your-vpc-id"
  # Choose a security group for your cluster
  security_group_id = "your-security-group-id"

  # Define your container registry configuration
  # Choose your preferred registry type
  registry_type = "ACR"

  # Enable the addons you need
  # Example for enabling ingress controller
  enable_addons = ["ingress-controller"]
}

# Create a Service Account for your cluster
resource "alicloud_cs_service_account" "main" {
  name     = "my-service-account"
  cluster_id = alicloud_cs_cluster.main.id
}

# Deploy your Kubernetes application
# Use the Kubernetes provider for further resources
# Example for deploying a simple nginx pod
resource "kubernetes_manifest" "nginx" {
  # Replace with your cluster connection information
  cluster_config {
    host     = "your-cluster-endpoint"
    username = "admin"
    password = "your-cluster-password"
  }

  manifest = <<EOF
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: default
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  namespace: default
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
EOF
}

  