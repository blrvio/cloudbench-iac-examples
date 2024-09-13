
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use o recurso mais recente
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "eastus"
}

# Crie um cluster Kubernetes no Azure Arc
resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-cluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kubernetes_version = "1.20.8"

  # Defina as configurações do cluster Kubernetes
  # ...
}

# Adicione uma conectividade do Azure Arc
resource "azurerm_connected_kubernetes_cluster" "example" {
  name                = "example-connected-cluster"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
}

# Crie um namespace no cluster Kubernetes no Azure Arc
resource "azurerm_kubernetes_namespace" "example" {
  name                = "example-namespace"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
}

# Crie um Deployment no cluster Kubernetes no Azure Arc
resource "azurerm_kubernetes_deployment" "example" {
  name                = "example-deployment"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  namespace           = azurerm_kubernetes_namespace.example.name

  # Defina as configurações do Deployment
  # ...
}

    