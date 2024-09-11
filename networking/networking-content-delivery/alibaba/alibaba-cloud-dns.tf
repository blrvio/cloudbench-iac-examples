
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud Access Key ID and Secret
  access_key = "your_access_key"
  secret_key = "your_secret_key"
  # Specify the region where your DNS service is located
  region = "cn-hangzhou"
}

# Create a DNS Record
resource "alicloud_dns_record" "example" {
  # The ID of the DNS zone you want to create records in
  zone_id = "your_zone_id"
  # Name of the DNS record, like `www` or `blog`
  name = "example"
  # Type of the DNS record, such as `A` or `CNAME`
  type = "A"
  # The value of the DNS record. This will depend on the type of record
  value = "1.2.3.4"
  # TTL (Time To Live) value for the record
  ttl = 300
}

  