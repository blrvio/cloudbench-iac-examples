
    # Configure the IBM Cloud Provider
provider "ibm" {
  region    = "us-south"
  account_id = "your_account_id"
}

# Create a load balancer group
resource "ibm_is_load_balancer_group" "main" {
  name                 = "my-load-balancer-group"
  load_balancer_type    = "public"
  instance_group_id     = "your_instance_group_id"
  health_check_interval = 30
  health_check_timeout  = 5
  health_check_retries  = 2
  # Create a default listener
  listeners = {
    "http" = {
      port      = 80
      protocol = "http"
    }
  }
}

# Create a backend pool
resource "ibm_is_load_balancer_pool" "main" {
  load_balancer_group_id = ibm_is_load_balancer_group.main.id
  name                    = "my-backend-pool"
  health_check_type        = "ping"
  health_check_path        = "/"
  members                  = ["your_instance_id"]
  # Add a backend pool to the listener
  listener = "http"
}

  