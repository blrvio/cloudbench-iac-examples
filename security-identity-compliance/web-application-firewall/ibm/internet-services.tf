
    # Configure the IBM Cloud Provider
provider "ibm-cloud" {
  # Replace with your IBM Cloud API Key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  # Replace with your IBM Cloud Region
  region  = "us-south"
}

# Create an IBM Cloud Internet Services instance
resource "ibm_cis_instance" "main" {
  name           = "my-cis-instance"
  # Specify the desired instance type
  instance_type = "basic"
  # Replace with your desired subnet
  subnet_id = "YOUR_SUBNET_ID"
  # Set the optional tags for the instance
  tags = {
    Name = "My CIS Instance"
  }
}

# Create a Firewall Rule for the Internet Services Instance
resource "ibm_cis_firewall_rule" "main" {
  instance_id  = ibm_cis_instance.main.id
  # Replace with your desired port number
  port          = 80
  protocol      = "tcp"
  # Define the source IP range
  source_cidr  = "0.0.0.0/0"
  # Set the optional rule name
  rule_name    = "allow-http"
}

  