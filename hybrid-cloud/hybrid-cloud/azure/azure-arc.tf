
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Kubernetes cluster
resource "azurerm_kubernetes_cluster" "example" {
  name                 = "example-cluster"
  location              = "westus2"
  resource_group_name = "example-resource-group"
  kubernetes_version  = "1.20.11"
  dns_prefix          = "example"
  # Enable AAD integration
  aad_profile {
    enabled             = true
    client_app_id       = "example-client-app-id"
    tenant_id           = "example-tenant-id"
    managed_identity_id = "example-managed-identity-id"
  }
  # Enable monitoring for the cluster
  monitoring {
    enabled = true
  }
  # Configure the network settings for the cluster
  network_profile {
    network_plugin = "azure"
  }
}

# Create a connected K8s cluster
resource "azurerm_connected_k8s_cluster" "example" {
  name                 = "example-connected-cluster"
  resource_group_name = "example-resource-group"
  location              = "westus2"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  # Enable Azure Monitor
  monitoring {
    enabled = true
  }
  # Define the identity used to connect to the cluster
  identity {
    type  = "systemAssigned"
  }
}

  