
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon Chime Account
resource "aws_chime_account" "main" {
  name = "my-chime-account" # Name of your Chime account

  # Optional settings
  # enable_sms = true # Enable SMS for the account
  # enable_voice = true # Enable voice for the account
  # default_calling_country_code = "US" # Set the default calling country code
  # enable_calling_features = true # Enable calling features
  # enable_chat = true # Enable chat for the account
  # enable_meeting_features = true # Enable meeting features
  # default_meeting_features = "basic" # Set the default meeting features (basic, advanced)
  # enable_phone_number_features = true # Enable phone number features
}

# Create an Amazon Chime User
resource "aws_chime_user" "main" {
  account_id = aws_chime_account.main.account_id # ID of the Chime account
  email      = "user@example.com" # Email address of the user
  username   = "user1" # Username of the user

  # Optional settings
  # full_name = "John Doe" # Full name of the user
  # user_type = "user" # Type of user (user, bot)
  # enable_calling = true # Enable calling for the user
  # enable_chat = true # Enable chat for the user
  # enable_meetings = true # Enable meetings for the user
  # allow_phone_number = true # Allow phone numbers for the user
}

# Create an Amazon Chime Voice Connector
resource "aws_chime_voice_connector" "main" {
  account_id   = aws_chime_account.main.account_id # ID of the Chime account
  name         = "my-voice-connector" # Name of the voice connector
  # Set the SIP endpoint details for the voice connector
  sip_media_application_endpoint {
    # endpoint_type = "application" # Type of endpoint
    # url = "https://example.com/" # URL of the SIP media application endpoint
  }

  # Optional settings
  # enable_phone_number_features = true # Enable phone number features
  # phone_number_features_type = "default" # Type of phone number features (default, custom)
}

  