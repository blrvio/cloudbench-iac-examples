
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud region
  region = "cn-hangzhou"
  # Replace with your Alibaba Cloud Access Key ID and Access Key Secret
  access_key = "your_access_key_id"
  secret_key = "your_access_key_secret"
}

# Create a DDoS Protection Instance
resource "alicloud_ddos_instance" "main" {
  # Choose a name for your DDoS protection instance
  instance_name = "my-ddos-instance"
  # Select the type of DDoS protection: Basic or Pro
  instance_type = "basic"
  # Choose the availability zone for the instance
  zone_id = "cn-hangzhou-a"
  # Set the bandwidth limit for your instance in Mbps
  bandwidth = 100
  # Enable auto renewal for the instance
  auto_renew = true
}

# Create a DDoS Protection Rule
resource "alicloud_ddos_rule" "main" {
  # Choose a name for your DDoS protection rule
  rule_name = "my-ddos-rule"
  # Associate the rule with the DDoS protection instance
  instance_id = alicloud_ddos_instance.main.id
  # Specify the IP address to protect
  ip = "1.2.3.4"
  # Select the type of DDoS protection: HTTP or TCP
  rule_type = "tcp"
}

  