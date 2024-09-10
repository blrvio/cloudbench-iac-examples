
    # Configure the IBM Cloud provider
provider "ibm" {
  # Replace with your IBM Cloud API Key
  api_key = "YOUR_API_KEY"
  # Replace with your IBM Cloud Region
  region = "us-south"
}

# Create a DNS zone
resource "ibm_dns_zone" "main" {
  name = "example.com"
  # Replace with your IBM Cloud Resource Group ID
  resource_group_id = "YOUR_RESOURCE_GROUP_ID"
}

# Create a DNS record
resource "ibm_dns_record" "main" {
  zone_id = ibm_dns_zone.main.id
  name = "www"
  type = "A"
  # Replace with the IP address of your server
  data = "1.2.3.4"
  ttl = 300
}

# Output the DNS zone ID
output "zone_id" {
  value = ibm_dns_zone.main.id
}

# Output the DNS record ID
output "record_id" {
  value = ibm_dns_record.main.id
}
  