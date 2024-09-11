
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a Server Load Balancer (SLB)
resource "alicloud_slb" "main" {
  name = "my-slb"
  address_type = "internet" # Internet-facing SLB
  internet_charge_type = "PayByBandwidth" # Billing by bandwidth
  # Optional settings
  bandwidth = 10 # Bandwidth in Mbps
  master_zone_id = "cn-hangzhou-a" # Select a master zone
  slave_zone_id = "cn-hangzhou-b" # Select a slave zone
}

# Create a Listener for the SLB
resource "alicloud_slb_listener" "main" {
  slb_id = alicloud_slb.main.id
  listener_port = 80 # Listen on port 80
  listener_protocol = "http" # Use HTTP protocol
  # Optional settings
  sticky_session_type = "server" # Enable sticky sessions
  sticky_session_cookie = "my_cookie" # Cookie name for sticky sessions
  health_check_type = "http" # Use HTTP health checks
  health_check_timeout = 3 # Health check timeout in seconds
  healthy_threshold = 2 # Healthy threshold for health checks
  unhealthy_threshold = 3 # Unhealthy threshold for health checks
}

# Create a Backend Server
resource "alicloud_ecs_instance" "backend_server" {
  # ... your backend server configuration
}

# Associate the Backend Server to the SLB Listener
resource "alicloud_slb_backend_server" "main" {
  slb_id = alicloud_slb.main.id
  listener_port = 80
  backend_server_id = alicloud_ecs_instance.backend_server.id
  port = 80 # Backend server port
  weight = 100 # Server weight
}

  