
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Habilite recursos recentes
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "openshift_rg" {
  name     = "openshift-rg"
  location = "westus2" # Substitua pela região desejada
}

# Crie um cluster do Azure Red Hat OpenShift
resource "azurerm_openshift_cluster" "openshift_cluster" {
  name                = "openshift-cluster"
  resource_group_name = azurerm_resource_group.openshift_rg.name
  location             = azurerm_resource_group.openshift_rg.location
  version             = "4.9"
  # ... (outras configurações)
}

# Crie um namespace
resource "azurerm_openshift_project" "my_namespace" {
  cluster_name     = azurerm_openshift_cluster.openshift_cluster.name
  resource_group_name = azurerm_resource_group.openshift_rg.name
  name               = "my-namespace"
}

# Importe uma imagem para o cluster
resource "azurerm_openshift_image" "my_image" {
  name                = "my-image"
  cluster_name     = azurerm_openshift_cluster.openshift_cluster.name
  resource_group_name = azurerm_resource_group.openshift_rg.name
  # ... (outras configurações)
}
    