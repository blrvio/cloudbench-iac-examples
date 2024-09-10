
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Blockchain Platform instance
resource "ibm_blockchain_platform" "main" {
  name     = "my-blockchain-platform"
  location = "us-south"
  # Specify plan for the instance, choose one based on your requirements
  plan = "starter"
  # Optionally, you can configure VPC settings
  # vpc_settings {
  #   vpc_network_id = "YOUR_VPC_NETWORK_ID"
  # }
  # Specify the required number of peers
  peer_count = 2
}

# Create a channel
resource "ibm_blockchain_platform_channel" "main" {
  platform_id = ibm_blockchain_platform.main.id
  name        = "my-channel"
}

# Create a smart contract
resource "ibm_blockchain_platform_smart_contract" "main" {
  platform_id   = ibm_blockchain_platform.main.id
  channel_name = ibm_blockchain_platform_channel.main.name
  name          = "my-contract"
  # Specify the contract code, using a local file or a URL
  code = "path/to/contract.go" # Replace with your contract path
  # You can also use a URL for the contract code
  # code = "https://raw.githubusercontent.com/your-org/your-repo/main/contract.go"
}

  