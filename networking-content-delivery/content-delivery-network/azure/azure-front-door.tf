
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Use the latest Azure provider features
}

# Create a Front Door
resource "azurerm_front_door" "main" {
  name                = "my-front-door"
  resource_group_name = "my-resource-group"
  location            = "westus2"
  # Define routing rules
  routing_rules {
    name                    = "my-routing-rule"
    frontend_endpoint_name  = "my-frontend-endpoint"
    backend_pool_name       = "my-backend-pool"
    http_port               = 80
    https_port              = 443
    # Route based on a condition
    conditions {
      match_values = ["example.com"]
      match_variable = "Hostname"
      operator        = "Equals"
    }
  }
  # Define frontend endpoints
  frontend_endpoints {
    name                     = "my-frontend-endpoint"
    hostname                  = "my-front-door.azureedge.net"
    session_affinity_enabled = false # Disable session affinity
    # Configure a custom domain
    custom_https_provisioning_enabled = false
  }
  # Define backend pools
  backend_pools {
    name = "my-backend-pool"
    # Define a single backend server
    backend_servers {
      address        = "192.168.0.1"
      http_port     = 80
      https_port    = 443
      priority      = 1
      weight        = 1
      enabled        = true
      server_name    = "my-backend-server"
      # Use a custom health probe
      health_probe_settings {
        protocol     = "Http"
        path         = "/healthcheck"
        interval      = 30
        timeout      = 10
        healthy_threshold = 2
        unhealthy_threshold = 5
      }
    }
  }
}
  