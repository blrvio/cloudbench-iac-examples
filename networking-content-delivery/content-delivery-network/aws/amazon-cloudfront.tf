
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um distribuição CloudFront
resource "aws_cloudfront_distribution" "my_distribution" {
  origin {
    domain_name = "s3-bucket-name.s3.amazonaws.com" # Substitua pelo nome do bucket S3
    origin_id  = "s3-origin"
  }

  enabled = true

  default_cache_behavior {
    target_origin_id = "s3-origin"
    viewer_protocol_policy = "allow-all"
    forwarded_values {
      cookies {
        forward = "none"
      }
      headers = ["Origin"]
      query_string = false
    }
  }

  # ... outras configurações da distribuição
}

# Crie um registro DNS para apontar um nome de domínio para a distribuição CloudFront
resource "aws_route53_record" "cloudfront_record" {
  name = "mydomain.com" # Substitua pelo seu nome de domínio
  type = "A"
  ttl  = 300
  zone_id = "Zxxxxxxxxxxxxx" # Substitua pelo ID da sua zona DNS Route 53
  records = [aws_cloudfront_distribution.my_distribution.domain_name]
}
    