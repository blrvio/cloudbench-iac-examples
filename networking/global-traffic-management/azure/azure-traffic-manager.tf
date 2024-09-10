
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable features for Azure provider
}

# Create a Traffic Manager Profile
resource "azurerm_traffic_manager_profile" "main" {
  name     = "my-traffic-manager-profile"
  resource_group_name = "my-resource-group"
  # Define the Traffic Manager profile type
  # Possible values are "Performance", "Priority", "Weighted"
  traffic_routing_method = "Performance"
  # Configure the DNS configuration
  dns_config {
    relative_name = "my-domain.com"
    ttl           = 300
  }
}

# Create a Traffic Manager Endpoint
resource "azurerm_traffic_manager_endpoint" "main" {
  name                 = "my-endpoint"
  profile_name         = azurerm_traffic_manager_profile.main.name
  resource_group_name = azurerm_traffic_manager_profile.main.resource_group_name
  # Define the endpoint type
  # Possible values are "AzureEndpoint", "ExternalEndpoint"
  type = "AzureEndpoint"
  # Configure the endpoint target
  target {
    # Specify the Azure resource ID of the backend service
    # e.g., "\/subscriptions\/\/resourcegroups\/my-resource-group\/providers\/microsoft.web\/sites\/my-web-app"
    azure_resource_id = "your-backend-resource-id"
  }
  # Define the endpoint weight
  # Only applicable to "Weighted" routing method
  weight = 10
  # Define the endpoint priority
  # Only applicable to "Priority" routing method
  priority = 1
}

  