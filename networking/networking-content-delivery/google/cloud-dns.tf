
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a managed zone
resource "google_dns_managed_zone" "main" {
  name    = "example-zone"
  dns_name = "example.com."
  description = "Example DNS zone"
}

# Create a record set
resource "google_dns_record_set" "main" {
  name    = "www"
  type    = "A"
  ttl     = 300
  managed_zone = google_dns_managed_zone.main.name
  # Add a list of records
  rrdatas = ["1.2.3.4", "5.6.7.8"]
}
  