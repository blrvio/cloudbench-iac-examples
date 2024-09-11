
    # Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a Blockchain Service instance
resource "huaweicloud_bcs_instance" "main" {
  name = "my-blockchain-instance" # Name of the instance
  type = "fabric-v2-0"
  # Optionally specify the version
  version = "1.4.3"
  # Specify the VPC network
  vpc_id = "vpc-12345678"
  # Specify the subnet ID
  subnet_id = "subnet-12345678"
  # Specify the security group ID
  security_group_ids = ["sg-12345678"]
  # Optional: Configure the instance storage
  storage_config {
    disk_type = "SATA"
    disk_size = 100
  }
  # Optional: Configure the instance data persistence
  data_persistence_config {
    enabled = true
  }
}

# Create a Blockchain Service network
resource "huaweicloud_bcs_network" "main" {
  instance_id = huaweicloud_bcs_instance.main.id
  name = "my-blockchain-network" # Name of the network
  # Configure the network channel
  channel_config {
    # Specify the channel name
    name = "my-blockchain-channel"
    # Specify the organization configuration
    organization_config {
      # Configure the organization name
      name = "my-blockchain-organization"
      # Configure the organization peers
      peer_config {
        # Configure the peer name
        name = "my-blockchain-peer"
        # Configure the peer port
        port = 7051
      }
    }
  }
}

  