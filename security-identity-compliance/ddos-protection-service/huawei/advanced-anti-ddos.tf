
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create an Advanced Anti-DDoS instance
resource "huaweicloud_aad_instance" "main" {
  name      = "my-aad-instance" # Name of the DDoS instance
  bandwidth = 1000 # Bandwidth of the DDoS instance in Mbps
  # Set the protection mode for the DDoS instance
  protection_mode = "all"
  # Set the type of DDoS protection
  type = "basic"
  # Configure the protection target for the DDoS instance
  protection_targets = [
    {
      target_type = "ip"
      target_id = "10.0.0.1"
    }
  ]
}

# Create a DDoS rule
resource "huaweicloud_aad_rule" "main" {
  name        = "my-aad-rule"
  instance_id = huaweicloud_aad_instance.main.id # ID of the DDoS instance
  # Set the rule type
  type        = "ip"
  # Set the rule action
  action      = "drop"
  # Configure the rule details
  details = {
    # Configure the IP address or subnet for the rule
    ip = "10.0.0.1"
    # Configure the port range for the rule
    port = 80
  }
}

  