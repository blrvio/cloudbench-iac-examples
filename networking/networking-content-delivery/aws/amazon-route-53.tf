
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma zona Hosted Zone
resource "aws_route53_zone" "example" {
  name = "example.com."
}

# Crie um registro A
resource "aws_route53_record" "example_a" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "www.example.com."
  type    = "A"
  ttl     = 300
  records = ["192.168.1.10"]
}
    