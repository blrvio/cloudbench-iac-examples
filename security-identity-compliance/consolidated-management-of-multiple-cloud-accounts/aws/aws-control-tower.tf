
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Control Tower
resource "aws_controltower_enabled" "main" {
  # Configure optional settings for Control Tower
  account_name_prefix = "my-control-tower-"
  # The region that will be used to create the landing zone
  landing_zone_region = "us-east-1"
  # Configure the optional settings for the Landing Zone
  landing_zone_options {
    # Configure optional settings for the delegated administrator accounts
    delegated_administrator_accounts {
      # You must specify at least one delegated administrator account
      # The IAM account ID of the account to be delegated administrator
      account_id = "123456789012" # Replace with your account ID
    }
  }
  # Enable Control Tower in this account
  enable = true
}

# Create a service control policy to control the services that can be used in the account
resource "aws_controltower_service_control_policy" "main" {
  # The name of the service control policy
  name = "MyServiceControlPolicy"
  # Define the rules for the service control policy
  rules = [
    # Allow the use of AWS EC2, AWS S3, and AWS CloudFront
    {
      # The service that the rule applies to
      service = "ec2"
      # The action that the rule allows
      action = "allow"
    },
    {
      # The service that the rule applies to
      service = "s3"
      # The action that the rule allows
      action = "allow"
    },
    {
      # The service that the rule applies to
      service = "cloudfront"
      # The action that the rule allows
      action = "allow"
    },
  ]
  # The policy's description
  description = "This policy controls the services that can be used in the account"
}

  