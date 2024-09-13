
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um certificado ACM
resource "aws_acm_certificate" "example" {
  domain_name = "example.com"
  validation_method = "DNS"

  # Crie um registro DNS para validação
  subject_alternative_names = ["www.example.com"]

  # Use os recursos de validação DNS do AWS
  # O provedor do Terraform cuidará do registro e da validação.
}

# Use o certificado ACM em outros serviços do AWS
# Ex: AWS CloudFront, AWS Application Load Balancer
# resource "aws_cloudfront_distribution" "example" {
#   ...
#   viewer_certificate {
#     cloudfront_default_certificate = false
#     minimum_protocol_version = "TLSv1.2_2016"
#     ssl_support_method = "sni-only"
#     acm_certificate_arn = aws_acm_certificate.example.arn
#   }
# }

    