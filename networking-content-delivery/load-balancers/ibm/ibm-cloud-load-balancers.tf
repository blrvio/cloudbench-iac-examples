
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "YOUR_IBM_API_KEY"
  region = "us-south"
}

# Crie um Load Balancer
resource "ibm_lb_load_balancer" "main" {
  name    = "my-load-balancer"
  location = "us-south"
  type    = "PUBLIC"
  sub_type = "HTTP"

  listener {
    protocol = "HTTP"
    port     = 80
  }
}

# Crie um backend Pool
resource "ibm_lb_pool" "main" {
  name     = "my-pool"
  location = "us-south"
  lb_id    = ibm_lb_load_balancer.main.id
  protocol = "HTTP"
  port     = 80
}

# Adicione um servidor ao backend Pool
resource "ibm_lb_server" "main" {
  name     = "my-server"
  location = "us-south"
  pool_id  = ibm_lb_pool.main.id
  address = "192.168.1.100"
  port    = 80
}
    