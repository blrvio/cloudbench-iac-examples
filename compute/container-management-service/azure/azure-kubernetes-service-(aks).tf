
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "my-aks-resource-group"
  location = "westus2"
}

# Create a Kubernetes cluster
resource "azurerm_kubernetes_cluster" "example" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "myakscluster"
  kubernetes_version  = "1.24.10"
  node_resource_group  = "my-aks-node-resource-group" # Create a separate resource group for node resources
  service_principal {
    client_id     = "your-app-client-id"
    client_secret = "your-app-client-secret"
  }
  # Choose the appropriate SKU for your workload
  sku {
    tier = "Standard"
    name = "Standard_D2s_v3"
  }
  # Define network settings for the cluster
  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.240.0.10"
    # Define a subnet for the cluster nodes
    subnet {
      name     = "my-aks-subnet"
      resource_group_name = "my-aks-vnet-resource-group"
      virtual_network_name  = "my-aks-vnet"
      address_prefixes = ["10.240.0.0/24"]
    }
  }
  # Enable advanced features
  enable_rbac            = true
  enable_pod_security_policy = true
  # Use a custom identity for the cluster
  identity {
    type = "SystemAssigned"
  }
  # Enable HTTPs-only mode for the Kubernetes API server
  https_only = true
}

# Create a Kubernetes namespace
resource "kubernetes_manifest" "example" {
  name      = "my-aks-namespace"
  manifest = <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: my-aks-namespace
EOF
  depends_on = [azurerm_kubernetes_cluster.example]
}

# Deploy a simple application to the cluster
resource "kubernetes_manifest" "app" {
  name      = "my-aks-app"
  namespace = kubernetes_manifest.example.name
  manifest = <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-aks-app
  labels:
    app: my-aks-app
  namespace: my-aks-namespace
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-aks-app
  template:
    metadata:
      labels:
        app: my-aks-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF
  depends_on = [azurerm_kubernetes_cluster.example]
}

# Create a service to expose the application
resource "kubernetes_manifest" "service" {
  name      = "my-aks-service"
  namespace = kubernetes_manifest.example.name
  manifest = <<EOF
apiVersion: v1
kind: Service
metadata:
  name: my-aks-service
  namespace: my-aks-namespace
  labels:
    app: my-aks-app
spec:
  selector: 
    app: my-aks-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
EOF
  depends_on = [azurerm_kubernetes_cluster.example]
}

  