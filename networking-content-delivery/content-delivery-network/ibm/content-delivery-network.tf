
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  # Replace with your IBM Cloud API key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a CDN instance
resource "ibm_cdn_instance" "main" {
  name = "my-cdn-instance"
  # Replace with your IBM Cloud resource group ID
  resource_group_id = "YOUR_RESOURCE_GROUP_ID"
  # Define the CDN configuration
  cdn_config {
    origin {
      # Replace with your origin server hostname
      hostname = "my-origin-server.com"
    }
    # Define the CDN cache behavior
    cache_behavior {
      # Set the default cache duration
      default_ttl = 3600
    }
  }
}

# Create a CDN origin
resource "ibm_cdn_origin" "main" {
  # Replace with your CDN instance ID
  instance_id = ibm_cdn_instance.main.id
  # Replace with your origin server hostname
  hostname = "my-origin-server.com"
  # Define the origin health check
  health_check {
    # Set the health check interval
    interval = 10
    # Set the health check timeout
    timeout = 2
    # Define the health check type
    type = "HTTP"
    # Define the health check path
    path = "/"
  }
}

# Create a CDN rule
resource "ibm_cdn_rule" "main" {
  # Replace with your CDN instance ID
  instance_id = ibm_cdn_instance.main.id
  # Define the rule pattern
  pattern = "/*"
  # Define the rule action
  action {
    # Set the cache duration for this rule
    cache_ttl = 300
  }
}

  