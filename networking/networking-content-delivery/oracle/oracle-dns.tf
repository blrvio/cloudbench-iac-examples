
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your desired region
  # Authenticate using your API key and secret
  # You can set these variables in your environment or in a separate file
  api_key = var.oci_api_key
  api_secret = var.oci_api_secret
}

# Create a DNS zone
resource "oci_dns_zone" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  name           = "example.com"
  # Define the DNS zone type
  # "PRIMARY" for a hosted zone
  # "SECONDARY" for a secondary zone
  zone_type = "PRIMARY"
  # Set the DNSSEC flags
  # "TRUE" to enable DNSSEC
  dnssec_enabled = false
}

# Create a DNS record
resource "oci_dns_record" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  zone_id        = oci_dns_zone.main.id
  name           = "www"
  # Define the record type
  # "A", "AAAA", "CNAME", "TXT", "SRV", etc.
  record_type = "A"
  # Define the record data
  data            = ["1.2.3.4"]
  # Set the TTL (time to live) for the record
  ttl              = 300
}
  