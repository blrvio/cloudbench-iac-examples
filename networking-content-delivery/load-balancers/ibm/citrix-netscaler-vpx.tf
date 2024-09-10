
    # Configure the IBM Cloud Provider
provider "ibm" {
  region     = "us-south"
  account_id = "YOUR_IBM_CLOUD_ACCOUNT_ID"
}

# Create a load balancer group
resource "ibm_lb_group" "main" {
  name    = "lb-group"
  location = "us-south"
  type    = "basic"
  subnets = ["YOUR_SUBNET_ID"]
  # Configure the health check
  health_check {
    port = 80
    path = "/"
    interval = 15
    timeout = 5
    retries  = 3
  }
  # Define the listeners for the load balancer group
  listeners {
    name     = "http"
    protocol = "HTTP"
    port     = 80
  }
}

# Create a virtual server
resource "ibm_lb_virtual_server" "main" {
  name     = "my-virtual-server"
  location = "us-south"
  lb_group = ibm_lb_group.main.id
  # Define the backend pool
  backend_pool {
    name   = "my-backend-pool"
    servers = ["YOUR_BACKEND_SERVER_IP"]
  }
  # Configure the listener
  listeners {
    name     = "http"
    protocol = "HTTP"
    port     = 80
  }
}

  