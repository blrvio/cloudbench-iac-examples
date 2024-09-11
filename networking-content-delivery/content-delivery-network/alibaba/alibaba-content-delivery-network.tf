
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud credentials
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
  region     = "cn-hangzhou"
}

# Create a CDN Domain
resource "alicloud_cdn_domain" "main" {
  domain  = "example.com"
  sources = ["http://your-origin-server.com"]
  # Enable HTTPS
  #  https_config {
  #    force_https = true
  #    http_2      = true
  #    cert_type = "self_signed"
  #    server_cert  = "your_certificate"
  #    server_key   = "your_key"
  #  }
  # Optional: Define the cache behavior
  #  cache_config {
  #    cache_content_type = "text/html"
  #    cache_time           = 3600
  #    follow_redirect      = true
  #    ignore_query_string  = false
  #    ignore_case         = true
  #    force_miss          = false
  #  }
}

# Create a CDN Domain Group
# resource "alicloud_cdn_domain_group" "main" {
#   name   = "MyCDNGroup"
#   domain = alicloud_cdn_domain.main.domain
#   #  Optional: Define the group settings
#   #  group_config {
#   #    # ...
#   #  }
# }
  