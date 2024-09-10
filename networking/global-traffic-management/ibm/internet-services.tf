
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key      = "YOUR_IBM_CLOUD_API_KEY" # Replace with your IBM Cloud API key
  region       = "us-south" # Replace with your desired region
  organization = "YOUR_IBM_CLOUD_ORGANIZATION" # Replace with your IBM Cloud organization
}

# Create an IBM Cloud Internet Services instance
resource "ibm_cis_instance" "main" {
  name      = "my-cis-instance" # Name of your CIS instance
  plan      = "standard" # Plan for your CIS instance
  zone      = "us-south-1" # Zone for your CIS instance
  # Optional: Add a custom domain
  domain  = "my-domain.com"
  # Optional: Configure SSL
  ssl_certificate_id = "YOUR_SSL_CERTIFICATE_ID"
  # Optional: Configure network settings
  network_settings = {
    ipv4_address = "1.2.3.4" # Optional: Use a specific IPv4 address
    network_id  = "YOUR_VPC_NETWORK_ID" # Optional: Specify a specific VPC network
  }
}

  