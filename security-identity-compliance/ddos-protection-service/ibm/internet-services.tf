
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "YOUR_API_KEY"
}

# Create an IBM Cloud Internet Services instance
resource "ibm_cis_instance" "main" {
  name = "my-cis-instance"
  location = "us-south"
  # Choose a plan
  plan = "standard"
  # Set up a static IP address
  static_ip = "192.168.1.10"
}

# Create a domain mapping
resource "ibm_cis_domain_mapping" "main" {
  instance_id = ibm_cis_instance.main.id
  domain = "mydomain.com"
  subdomain = "www"
}

# Create a DNS record for the domain
resource "ibm_cis_dns_record" "main" {
  instance_id = ibm_cis_instance.main.id
  domain = "mydomain.com"
  name = "www"
  type = "A"
  data = "192.168.1.10"
}

  