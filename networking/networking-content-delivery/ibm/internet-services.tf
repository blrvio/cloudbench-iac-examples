
    # Configure the IBM Cloud provider
provider "ibm" {
  # Replace with your IBM Cloud API key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  # Replace with your IBM Cloud region
  region = "us-south"
}

# Create an Internet Service
resource "ibm_cis_service" "main" {
  name = "my-internet-service"
  # Choose the appropriate service type
  type = "public"
  # Define the network settings
  network {
    cidr = "10.0.0.0/16"
  }
  # Optional: Assign tags
  tags = {
    "env" = "dev"
  }
}

# Create a Network Interface Card (NIC)
resource "ibm_cis_nic" "main" {
  service_id = ibm_cis_service.main.id
  # Choose the appropriate NIC type
  type = "eth0"
  # Optional: Assign a specific subnet
  # subnet = "your-subnet-id"
}

  