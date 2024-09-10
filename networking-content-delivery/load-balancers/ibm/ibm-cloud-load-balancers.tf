
    # Configure the IBM Cloud Provider
provider "ibm" {
  region = "us-south"
  ibmcloud_api_key = "your_ibmcloud_api_key"
}

# Create a Load Balancer
resource "ibm_is_load_balancer" "main" {
  name = "my-load-balancer"
  location = "us-south"
  resource_group = "your_resource_group_id"

  # Define the listeners for the load balancer
  listener {
    protocol = "http"
    port = 80
  }
  listener {
    protocol = "https"
    port = 443
  }

  # Define the backend targets for the load balancer
  backend_target {
    instance_id = "your_instance_id"
    port = 8080
  }

  # Configure the health check for the load balancer
  health_check {
    type = "tcp"
    port = 8080
    interval = 5
    timeout = 2
    retries = 3
  }
}

# Create a Security Group
resource "ibm_is_security_group" "main" {
  name = "my-security-group"
  location = "us-south"
  resource_group = "your_resource_group_id"
  # Define the rules for the security group
  rule {
    direction = "ingress"
    protocol = "tcp"
    port = 80
    cidr = "0.0.0.0/0"
  }
  rule {
    direction = "ingress"
    protocol = "tcp"
    port = 443
    cidr = "0.0.0.0/0"
  }
}

  