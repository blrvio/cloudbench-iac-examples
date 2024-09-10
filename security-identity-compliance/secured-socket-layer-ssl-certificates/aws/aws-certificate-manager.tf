
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a certificate in AWS Certificate Manager (ACM)
resource "aws_acm_certificate" "main" {
  domain_name = "example.com" # Replace with your domain name
  validation_method = "DNS" # Choose the validation method
  # The validation method can be either DNS or EMAIL
  subject_alternative_names = ["*.example.com", "test.example.com"] # Add any additional domain names
  # If you need to add Subject Alternative Names

  # Optionally you can use an existing certificate ARN
  # certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
}

# Create a validation record
resource "aws_route53_record" "main" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_acm_certificate.main.domain_validation_options.0.resource_record.name
  type    = aws_acm_certificate.main.domain_validation_options.0.resource_record.type
  ttl     = 300
  records = [aws_acm_certificate.main.domain_validation_options.0.resource_record.value]
}

# Create a Route 53 Hosted Zone to store the validation record
resource "aws_route53_zone" "main" {
  name = "example.com" # Replace with your domain name
}

# Optionally, create an ACM Certificate Validation Record
#resource "aws_acm_certificate_validation" "main" {
#  certificate_arn = aws_acm_certificate.main.arn
#  validation_record.name = aws_route53_record.main.name
#  validation_record.type = aws_route53_record.main.type
#  validation_record.value = aws_route53_record.main.records.0
#}

  