
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create a Direct Link connection
resource "ibm_directlink_connection" "main" {
  name     = "my-directlink-connection"
  location = "us-south"
  # Specify the Direct Link gateway to connect to
  gateway_id = "YOUR_DIRECT_LINK_GATEWAY_ID"
  # Specify the virtual circuit to connect to
  virtual_circuit_id = "YOUR_VIRTUAL_CIRCUIT_ID"
  # Specify the bandwidth of the connection
  bandwidth = "100Mbps"
}

  