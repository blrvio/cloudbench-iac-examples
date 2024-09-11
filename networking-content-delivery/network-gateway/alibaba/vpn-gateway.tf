
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a VPN Gateway
resource "alicloud_vpn_gateway" "main" {
  name           = "my-vpn-gateway" # Name of the VPN Gateway
  vpc_id         = "vpc-abc12345" # ID of the VPC
  bandwidth       = 5 # Bandwidth in Mbps
  instance_charge_type = "PostPaid" # Charging type (PostPaid or PrePaid)
  description     = "My VPN Gateway"
}

# Create a VPN Connection
resource "alicloud_vpn_connection" "main" {
  name         = "my-vpn-connection" # Name of the VPN Connection
  local_subnet = "192.168.1.0/24" # Local subnet IP range
  remote_subnet = "172.16.0.0/16" # Remote subnet IP range
  vpn_gateway_id = alicloud_vpn_gateway.main.id # ID of the VPN Gateway
  type         = "ipsec" # Connection type (ipsec)
  # Optional: Set the VPN Connection policy
  # ike_config {
  #   pfs = "true"
  #   encryption = "aes-256-cbc"
  #   authentication = "sha1"
  # }
  # ipsec_config {
  #   encryption = "aes-256-cbc"
  #   authentication = "sha1"
  #   pfs = "true"
  # }
}

# Create a Customer Gateway
resource "alicloud_vpn_customer_gateway" "main" {
  name           = "my-customer-gateway" # Name of the Customer Gateway
  ip_address     = "10.10.10.10" # Public IP address of the customer gateway
  description     = "My Customer Gateway"
  # Optional: Set the Customer Gateway policy
  # ike_config {
  #   pfs = "true"
  #   encryption = "aes-256-cbc"
  #   authentication = "sha1"
  # }
  # ipsec_config {
  #   encryption = "aes-256-cbc"
  #   authentication = "sha1"
  #   pfs = "true"
  # }
}
  