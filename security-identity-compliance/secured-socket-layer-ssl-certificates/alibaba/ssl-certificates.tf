
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um certificado SSL
resource "aws_acm_certificate" "example" {
  domain_name = "example.com" # Substitua pelo nome do domínio
  validation_method = "DNS"
}

# Crie uma validação DNS
resource "aws_route53_record" "validation" {
  name    = "_*.example.com" # Substitua pelo nome do domínio
  type    = "TXT"
  ttl     = 300
  zone_id = "Zxxxxxxxxxxxxx" # Substitua pelo ID da sua zona DNS

  records = [aws_acm_certificate.example.validation_record_fqdns.0]
}
    