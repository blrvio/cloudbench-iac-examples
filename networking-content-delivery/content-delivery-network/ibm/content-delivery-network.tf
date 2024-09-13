
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um bucket S3 para armazenar os arquivos estáticos
resource "aws_s3_bucket" "static_content" {
  bucket = "my-static-content"
  acl    = "public-read"
}

# Crie um distribuição CloudFront
resource "aws_cloudfront_distribution" "static_distribution" {
  origin {
    domain_name = aws_s3_bucket.static_content.bucket_regional_domain_name
    origin_id  = "s3-origin"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods    = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "s3-origin"
    viewer_protocol_policy = "allow-all"
    min_ttl              = 0
    max_ttl              = 31536000
    default_ttl          = 86400
  }
  enabled = true
}

# Configure o endpoint do CloudFront
output "cloudfront_domain" {
  value = aws_cloudfront_distribution.static_distribution.domain_name
}
    