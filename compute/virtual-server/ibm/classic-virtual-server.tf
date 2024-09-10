
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key  = "YOUR_IBM_CLOUD_API_KEY"  # Replace with your IBM Cloud API key
  region   = "us-south"            # Replace with your desired region
}

# Create a Classic Virtual Server
resource "ibm_vsi" "main" {
  name     = "my-vsi"                # Replace with your desired name
  zone     = "us-south-1"           # Replace with your desired zone
  image     = "centos-7-6"           # Replace with your desired image
  profile  = "standard-2"           # Replace with your desired profile
  disk_size = 100                      # Replace with your desired disk size
  # Optional: Configure the server's network
  network_interface {
    # Define the network to use for the server
    network_id = "YOUR_NETWORK_ID" # Replace with your desired network ID
    subnet_id = "YOUR_SUBNET_ID" # Replace with your desired subnet ID
  }
}

  