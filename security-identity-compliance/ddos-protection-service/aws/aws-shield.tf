
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Shield Protection
resource "aws_shield_protection" "main" {
  name  = "my-shield-protection"
  # The type of protection to enable. Valid values are `STANDARD` or `ADVANCED`
  # `STANDARD` protection is free for all AWS customers. `ADVANCED` protection requires a paid subscription.
  protection_type = "STANDARD"

  # Optional: Enable automatic mitigation for DDoS attacks
  # auto_mitigation_config {
  #   mitigation_type = "PROTECTIVE_ACTION" # Can be `PROTECTIVE_ACTION` or `NO_ACTION`
  #   # Use the `PROTECTIVE_ACTION` mitigation type to automatically implement defensive measures against DDoS attacks.
  #   # Use the `NO_ACTION` mitigation type to disable automatic mitigation and manually mitigate DDoS attacks.
  #   # The `NO_ACTION` mitigation type is only available for Advanced protection.
  # }

  # Optional: Create a resource that represents a web application or service that you want to protect with Shield.
  # resource_arn = "arn:aws:cloudfront::123456789012:distribution/E12345678901234567890123456789012"

  # Optional: The name of the Shield protection group to associate with. If you want to enable Shield Advanced for a CloudFront distribution, use the default Shield protection group, which is the one with the name of the Shield protection group created when you create an Advanced protection.
  # shield_protection_group_id = aws_shield_protection_group.example.id
}

# Create a Shield Protection Group
resource "aws_shield_protection_group" "example" {
  name  = "my-shield-protection-group"
  # The type of protection to enable. Valid values are `STANDARD` or `ADVANCED`
  # `STANDARD` protection is free for all AWS customers. `ADVANCED` protection requires a paid subscription.
  protection_type = "STANDARD"

  # Optional: Enable automatic mitigation for DDoS attacks
  # auto_mitigation_config {
  #   mitigation_type = "PROTECTIVE_ACTION" # Can be `PROTECTIVE_ACTION` or `NO_ACTION`
  #   # Use the `PROTECTIVE_ACTION` mitigation type to automatically implement defensive measures against DDoS attacks.
  #   # Use the `NO_ACTION` mitigation type to disable automatic mitigation and manually mitigate DDoS attacks.
  #   # The `NO_ACTION` mitigation type is only available for Advanced protection.
  # }

  # Optional: Create a resource that represents a web application or service that you want to protect with Shield.
  # resource_arn = "arn:aws:cloudfront::123456789012:distribution/E12345678901234567890123456789012"

  # Optional: The name of the Shield protection group to associate with. If you want to enable Shield Advanced for a CloudFront distribution, use the default Shield protection group, which is the one with the name of the Shield protection group created when you create an Advanced protection.
  # shield_protection_group_id = aws_shield_protection_group.example.id
}
  