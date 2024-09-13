
      # Configure o provedor Alibaba Cloud
provider "alicloud" {
  # Credenciais de acesso
  access_key  = "YOUR_ACCESS_KEY_ID"
  secret_key = "YOUR_ACCESS_KEY_SECRET"
  region      = "cn-hangzhou"
}

# Crie um domínio
resource "alicloud_dns_domain" "example_domain" {
  domain_name = "example.com"
}

# Crie um registro A
resource "alicloud_dns_record" "a_record" {
  domain_name = alicloud_dns_domain.example_domain.domain_name
  type        = "A"
  rr          = "www"
  value        = "1.1.1.1"
  ttl         = 600
}

# Crie um registro CNAME
resource "alicloud_dns_record" "cname_record" {
  domain_name = alicloud_dns_domain.example_domain.domain_name
  type        = "CNAME"
  rr          = "mail"
  value        = "mail.example.com"
  ttl         = 600
}

# Crie um registro TXT
resource "alicloud_dns_record" "txt_record" {
  domain_name = alicloud_dns_domain.example_domain.domain_name
  type        = "TXT"
  rr          = "google-site-verification"
  value        = "YOUR_GOOGLE_SITE_VERIFICATION_CODE"
  ttl         = 600
}
    