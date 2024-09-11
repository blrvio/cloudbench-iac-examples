
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1"
}

# Create a security group
resource "huaweicloud_vpc_security_group" "main" {
  name        = "my-security-group"
  description = "Security group for Open APIs"
  vpc_id      = "your_vpc_id"
  rules {
    direction = "ingress"
    protocol  = "tcp"
    port_range = "80,443"
    cidr_ips  = ["0.0.0.0/0"]
  }
}

# Create a virtual machine
resource "huaweicloud_ecs_server" "main" {
  name = "my-vm"
  image_id = "your_image_id"
  flavor_id = "your_flavor_id"
  vpc_id = "your_vpc_id"
  security_group_ids = [huaweicloud_vpc_security_group.main.id]
}

# Create a load balancer
resource "huaweicloud_elb_listener" "main" {
  loadbalancer_id = "your_loadbalancer_id"
  port            = 80
  protocol        = "HTTP"
  # Add the server to the load balancer
  backend_servers {
    server_id = huaweicloud_ecs_server.main.id
    port       = 80
    weight      = 1
  }
}
  