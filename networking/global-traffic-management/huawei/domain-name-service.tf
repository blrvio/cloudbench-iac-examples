
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west1"
}

# Create a DNS zone
resource "huaweicloud_dns_zone" "main" {
  name = "example.com"
  # Define the zone's properties
  ttl = 600
  # Define the zone's records
  record {
    type = "A"
    name = "www"
    value = "192.168.1.1"
  }
  # Define the zone's master domain
  master_domain = "master-domain.example.com"
  # Define the zone's master domain port
  master_domain_port = 53
}

  