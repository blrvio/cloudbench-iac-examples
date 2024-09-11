
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create an SSL certificate
resource "huaweicloud_scm_certificate" "main" {
  common_name = "example.com" # Replace with your domain name
  # Optional settings
  csr = "---
# Your CSR here
---"
  # Use the `huaweicloud_scm_private_key` resource to generate a private key and CSR
  private_key = "---
# Your private key here
---"
  # Enable automatic renewal of the certificate
  auto_renewal = true
}

# Create a validation record for the certificate
resource "huaweicloud_scm_validation_record" "main" {
  certificate_id = huaweicloud_scm_certificate.main.id
  # Choose a validation method
  validation_method = "dns"
  # Use the `huaweicloud_dns_record` resource to manage DNS records
  dns_record_id = "example-validation-record"
}

  