
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Cognito User Pool
resource "aws_cognito_user_pool" "main" {
  name = "my-user-pool"
  # Define the email verification settings
  email_verification_message = "Welcome! Please verify your email address."
  email_verification_subject = "Verify Your Email Address"

  # Configure the password policy
  password_policy {
    minimum_length = 8 # Minimum password length
    require_lowercase = true # Require lowercase characters
    require_uppercase = true # Require uppercase characters
    require_numbers = true # Require numbers
    require_symbols = true # Require symbols
  }

  # Define the user pool attributes
  user_pool_add_ons {
    advanced_security_mode = "OFF" # Disable advanced security features
    # Configure the MFA settings
    mfa_configuration {  
      sms_configuration {  
        sms_authentication_message = "Your MFA code is: {####}" # Define the SMS message
        # Define the SMS provider
        # sms_provider_arn = aws_sns_topic.main.arn
      }
    }
  }
}

# Create a Cognito User Pool Client
resource "aws_cognito_user_pool_client" "main" {
  user_pool_id = aws_cognito_user_pool.main.id
  client_name = "my-user-pool-client"
  # Enable the client to allow users to sign up
  generate_secret = true
  # Configure the allowed OAuth flows
  allowed_oauth_flows = ["code", "implicit", "client_credentials", "password"]
  # Specify the callback URLs for the client
  callback_urls = ["http://localhost:3000/callback", "https://my-app.com/callback"]
  # Configure the logout URLs for the client
  logout_urls = ["http://localhost:3000", "https://my-app.com"]
}

# Create a Cognito Identity Pool
resource "aws_cognito_identity_pool" "main" {
  identity_pool_name = "my-identity-pool"
  allow_unauthenticated_identities = false # Disable unauthenticated access
  # Configure the Cognito User Pool
  cognito_identity_providers {
    provider_name = aws_cognito_user_pool.main.id
    client_id = aws_cognito_user_pool_client.main.id
  }
}

# Create an SNS Topic for SMS notifications
# resource "aws_sns_topic" "main" {
#   name = "my-sns-topic"
# }

  