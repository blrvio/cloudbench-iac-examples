
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  # Replace with your IBM Cloud API key
  api_key = "YOUR_API_KEY"
}

# Create a Secure Gateway
resource "ibm_secure_gateway_gateway" "main" {
  name     = "my-secure-gateway"
  location = "us-south"

  # Define the type of Secure Gateway
  gateway_type = "default"
}

# Create a Secure Gateway connection
resource "ibm_secure_gateway_connection" "main" {
  gateway_id = ibm_secure_gateway_gateway.main.id
  name        = "my-connection"
  # Define the connection type
  connection_type = "direct"
  # Define the remote network to connect to
  remote_network = "YOUR_REMOTE_NETWORK_ID"
  # Define the remote network's security group
  security_group = "YOUR_SECURITY_GROUP_ID"
}

# Create a Secure Gateway rule
resource "ibm_secure_gateway_rule" "main" {
  gateway_id = ibm_secure_gateway_gateway.main.id
  name        = "my-rule"
  # Define the rule's action
  action     = "allow"
  # Define the rule's protocol
  protocol = "tcp"
  # Define the rule's source and destination ports
  source_port = 80
  dest_port   = 80
}

  