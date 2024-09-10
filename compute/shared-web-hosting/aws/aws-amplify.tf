
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amplify App
resource "aws_amplify_app" "main" {
  name = "my-amplify-app" # Name of your Amplify app

  # Optional settings
  auto_branch_creation_patterns = ["main"] # Automatically create branches for specific patterns
  auto_branch_creation_config {
    basic_auth_config {
      enable_basic_auth = false # Disable basic authentication by default
    }
  }
  # Define the app's environment configurations
  environment {
    # Define notification configurations
    notification_config {
      # Configure Slack notification parameters
      slack {
        channel = "my-slack-channel" # Name of the Slack channel
        webhook_url = "https://hooks.slack.com/services/..." # Slack webhook URL
      }
    }
  }
}

# Create an Amplify Branch
resource "aws_amplify_branch" "main" {
  app_id = aws_amplify_app.main.id # ID of the Amplify app
  name    = "main" # Name of the branch
  stage   = "PROD" # Stage of the branch
  # Define the branch creation configurations
  build_spec = <<EOF
version: 0.2
frontend:
  phases:
    preBuild:
      commands:
        - echo "Pre-build" # Execute commands before build
    build:
      commands:
        - echo "Build" # Execute commands to build the app
    postBuild:
      commands:
        - echo "Post-build" # Execute commands after build
EOF

  # Define the branch's environment configurations
  environment {
    # Define notification configurations
    notification_config {
      # Configure Slack notification parameters
      slack {
        channel = "my-slack-channel" # Name of the Slack channel
        webhook_url = "https://hooks.slack.com/services/..." # Slack webhook URL
      }
    }
  }
}

# Create a custom domain for the Amplify app
resource "aws_amplify_domain" "main" {
  app_id  = aws_amplify_app.main.id
  domain  = "my-domain.com"
  subdomain = "www"

  # Optional settings
  enable_cloudfront_mutli_az = true # Enable CloudFront Multi-AZ
  enable_automated_branch_creation = false # Disable automatic branch creation

  # Define SSL certificate configurations
  certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
  # You can use the `aws_acm_certificate` resource to create a new SSL certificate
  # Example:
  # resource "aws_acm_certificate" "main" {
  #   domain_name = "my-domain.com"
  #   validation_method = "DNS"
  #   subject_alternative_names = ["www.my-domain.com"]
  # }
}

  