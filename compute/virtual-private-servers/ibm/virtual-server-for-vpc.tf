
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  # Replace with your IBM Cloud account credentials
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a VPC network
resource "ibm_vpc_network" "main" {
  name = "my-vpc-network"
  # Choose an existing or create a new VPC network
  classic_network_id = "YOUR_CLASSIC_NETWORK_ID"
}

# Create a Virtual Server Instance (VSI) in the VPC network
resource "ibm_vsi" "main" {
  name = "my-vsi"
  # Select an existing or create a new VSI profile
  profile_name = "YOUR_VSI_PROFILE_NAME"
  # Choose an existing or create a new image
  image_id = "YOUR_IMAGE_ID"
  # Select an existing or create a new subnet
  subnet_id = "YOUR_SUBNET_ID"
  # Define the VPC network where the VSI will be created
  network_id = ibm_vpc_network.main.id
}

  