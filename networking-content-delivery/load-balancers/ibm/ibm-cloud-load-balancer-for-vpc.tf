
      # Configure o provedor IBM Cloud
provider "ibm" {
  region = "us-south"
  api_key = "your_api_key"
}

# Crie um Load Balancer
resource "ibm_lb_load_balancer" "main" {
  name     = "my-load-balancer"
  vpc_id   = "vpc-xxxxxxxx"
  subnet_ids = ["subnet-xxxxxxxx"]
  listener {
    port = 80
    protocol = "http"
    target_group_id = ibm_lb_target_group.main.id
  }
}

# Crie um Target Group
resource "ibm_lb_target_group" "main" {
  name        = "my-target-group"
  vpc_id      = "vpc-xxxxxxxx"
  health_check {
    protocol = "tcp"
    port      = 80
    timeout   = 5
    interval  = 10
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

# Adicione servidores ao Target Group
resource "ibm_lb_target" "web_server" {
  target_group_id = ibm_lb_target_group.main.id
  target_type = "instance"
  instance_id = "instance-xxxxxxxx"
  port = 80
}
    