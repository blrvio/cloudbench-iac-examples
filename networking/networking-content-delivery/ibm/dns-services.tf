
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma zona DNS
resource "aws_route53_zone" "example_zone" {
  name = "example.com"
}

# Crie um registro DNS
resource "aws_route53_record" "example_record" {
  zone_id = aws_route53_zone.example_zone.zone_id
  name    = "www"
  type    = "A"
  ttl     = 300
  records = ["192.168.0.10"]
}
    