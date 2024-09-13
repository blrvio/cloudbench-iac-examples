
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um recurso do AWS Shield Standard
resource "aws_shield_protection" "example" {
  name = "example"

  resource_arn = "arn:aws:cloudfront::123456789012:distribution/E1234567890ABC1234567890"
}

# Crie um recurso do AWS Shield Advanced
resource "aws_shield_advanced_protection" "example" {
  name         = "example"
  resource_arn = "arn:aws:cloudfront::123456789012:distribution/E1234567890ABC1234567890"
}

    