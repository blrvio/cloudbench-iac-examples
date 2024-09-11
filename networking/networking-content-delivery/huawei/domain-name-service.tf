
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a DNS zone
resource "huaweicloud_dns_zone" "example" {
  name  = "example.com"
  # Create the zone with the specified name.
  type = "public" # Can be public or private
}

# Create a DNS record
resource "huaweicloud_dns_record" "example" {
  zone_id  = huaweicloud_dns_zone.example.id
  name = "www"
  # Create a record with the specified name, type, and data.
  type = "A"
  # You can use any valid IP address here.
  data = "1.2.3.4"
}

  