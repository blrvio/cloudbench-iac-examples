
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create a Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-openshift-rg"
  location = "eastus"
}

# Create an OpenShift Cluster
resource "azurerm_openshift_cluster" "main" {
  name                = "my-openshift-cluster"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  # Set your desired OpenShift version
  version              = "4.10"
  # Set the number of worker nodes
  worker_node_count    = 3
  # Set the desired worker node size
  worker_node_size      = "Standard_D2s_v3"
  # Optional: Configure the Kubernetes API Server
  kubernetes_api_server_private_base_domain_name = "my-openshift-cluster.hcp.eastus.azmk8s.io"
}

# Output the OpenShift Cluster ID
output "cluster_id" {
  value = azurerm_openshift_cluster.main.id
}

# Output the OpenShift Cluster URI
output "cluster_uri" {
  value = azurerm_openshift_cluster.main.kubernetes_api_server_uri
}
  