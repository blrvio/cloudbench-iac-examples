
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  user_ocid  = "ocid1.user.oc1..aaaaaaaayyyyyyyyyyyyyy"
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxx"
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Create a Load Balancer
resource "oci_load_balancer" "main" {
  name    = "my-load-balancer"
  shape  = "LOAD_BALANCER_SHAPE_1_4"
  subnet_ids = ["ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa"]
  
  # Optional settings
  #  load_balancer_type = "INTERNAL"
  #  shape = "LOAD_BALANCER_SHAPE_4_8"
}

# Create a Listener
resource "oci_load_balancer_listener" "main" {
  load_balancer_id = oci_load_balancer.main.id
  name             = "my-listener"
  port             = 443
  #  protocol         = "TCP"
  #  ssl_policy      = "DEFAULT"
  
  # Create a Backend Set
  backend_set {
    name            = "my-backend-set"
    backend_set_type = "INTERNAL"
    
    # Create a Backend
    backend {
      name    = "my-backend"
      port    = 80
      protocol = "TCP"
      targets = [
        "ocid1.instance.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa"
      ]
    }
  }
}

  