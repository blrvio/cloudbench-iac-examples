
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a VPN connection
resource "huaweicloud_vpn_connection" "main" {
  name = "my-vpn-connection"
  # Replace with the ID of your VPN gateway
  vpn_gateway_id = "vpnx-xxxxxx"
  # Replace with the ID of your customer gateway
  customer_gateway_id = "cgw-xxxxxx"
  # Replace with the IP address of your customer gateway
  customer_gateway_ip_address = "10.10.10.1"
  # Replace with the type of encryption
  ipsec_encryption_algorithm = "aes-128"
  # Replace with the type of authentication
  ipsec_authentication_algorithm = "sha1"
  # Replace with the VPN connection type
  vpn_connection_type = "site-to-site"
}

  