
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an S3 bucket for static website hosting
resource "aws_s3_bucket" "static_website" {
  bucket = "my-static-website-bucket"
  acl    = "public-read"

  # Configure website hosting settings
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  # Enable versioning for the bucket
  versioning {
    enabled = true
  }
}

# Create an AWS CloudFront distribution
resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = aws_s3_bucket.static_website.bucket_domain_name
    origin_id   = "s3-origin"
    custom_origin_config {
      # Set the origin protocol policy
      origin_protocol_policy = "http-only"
      # Specify the HTTP port for the origin
      http_port = 80
      # Specify the HTTPS port for the origin
      https_port = 443
    }
  }

  # Configure the distribution settings
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "My CloudFront Distribution"
  default_root_object = "index.html"
  # Define the default cache behavior
  default_cache_behavior {
    target_origin_id = "s3-origin"
    # Configure the allowed HTTP methods
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    # Specify the cached content's TTL
    forwarded_values {
      # Forward all query strings
      query_string = true
      # Forward cookies
      cookies {
        forward = "all"
      }
    }
    # Set the minimum TTL for the cache
    min_ttl = 0
    # Set the maximum TTL for the cache
    max_ttl = 31536000
    # Set the default TTL for the cache
    default_ttl = 86400
  }

  # Configure the logging settings
  logging_config {
    include_cookies = false
    # Specify the S3 bucket for logs
    bucket = "my-cloudfront-logs"
    # Prefix for the logs
    prefix = "cloudfront-logs/"
  }

  # Enable HTTPS for the distribution
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  # Define the distribution's price class
  price_class = "PriceClass_100"
}

# Create an IAM policy for CloudFront
resource "aws_iam_policy" "cloudfront_policy" {
  name = "cloudfront-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ],
        "Resource" : [
          "arn:aws:s3:::my-static-website-bucket/*"
        ]
      }
    ]
  })
}

# Attach the policy to the CloudFront service role
resource "aws_iam_policy_attachment" "cloudfront_attachment" {
  name       = "cloudfront-policy-attachment"
  policy_arn = aws_iam_policy.cloudfront_policy.arn
  roles      = [aws_iam_role.cloudfront_role.arn]
}

# Create an IAM role for CloudFront
resource "aws_iam_role" "cloudfront_role" {
  name = "cloudfront-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

  