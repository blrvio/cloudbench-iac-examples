
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Blockchain as a Service instance
resource "alicloud_blockchain_instance" "main" {
  instance_type = "BAAS_STANDARD_1" # Blockchain instance type
  vpc_id = "vpc-abc1234567890" # Replace with your VPC ID
  vswitch_id = "vsw-abc1234567890" # Replace with your VSwitch ID
  name = "my-blockchain-instance" # Name of the instance

  # Optional configuration
  description = "My blockchain instance"
  tags = {
    # Add your own tags
    Name = "My Blockchain Instance"
  }
}

# Configure the Blockchain network
resource "alicloud_blockchain_network" "main" {
  instance_id = alicloud_blockchain_instance.main.id
  name = "my-blockchain-network" # Name of the network

  # Optional configuration
  description = "My blockchain network"
  tags = {
    # Add your own tags
    Name = "My Blockchain Network"
  }
}

# Create a blockchain channel
resource "alicloud_blockchain_channel" "main" {
  network_id = alicloud_blockchain_network.main.id
  name = "my-blockchain-channel" # Name of the channel

  # Optional configuration
  description = "My blockchain channel"
  tags = {
    # Add your own tags
    Name = "My Blockchain Channel"
  }
}

  