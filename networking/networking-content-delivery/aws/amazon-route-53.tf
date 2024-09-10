
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Route 53 Hosted Zone
resource "aws_route53_zone" "main" {
  name = "example.com." # Replace with your domain name

  # Optional settings
  comment = "My Route 53 Hosted Zone"

  # Configure delegation set if needed
  # delegation_set_id = aws_route53_delegation_set.example.id
}

# Create a Route 53 Record Set (A Record)
resource "aws_route53_record" "a_record" {
  name    = "www" # Replace with your subdomain
  type    = "A"
  zone_id = aws_route53_zone.main.zone_id
  ttl     = 300              # Time to Live in seconds
  records = ["192.168.0.10"] # Replace with your IP address
}

# Create a Route 53 Record Set (CNAME Record)
resource "aws_route53_record" "cname_record" {
  name    = "alias" # Replace with your subdomain
  type    = "CNAME"
  zone_id = aws_route53_zone.main.zone_id
  ttl     = 300             # Time to Live in seconds
  records = ["example.com"] # Replace with your target domain name
}

# Create a Route 53 Record Set (TXT Record)
resource "aws_route53_record" "txt_record" {
  name    = "_dmarc" # Replace with your subdomain
  type    = "TXT"
  zone_id = aws_route53_zone.main.zone_id
  ttl     = 300                                     # Time to Live in seconds
  records = ["v=spf1 include:_spf.google.com ~all"] # Replace with your TXT record value
}

# Create a Route 53 Record Set (SRV Record)
resource "aws_route53_record" "srv_record" {
  name    = "_sip._tcp" # Replace with your subdomain
  type    = "SRV"
  zone_id = aws_route53_zone.main.zone_id
  ttl     = 300                      # Time to Live in seconds
  records = ["0 1 5060 example.com"] # Replace with your SRV record values
}

  