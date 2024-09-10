
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an SES configuration set
resource "aws_ses_configuration_set" "main" {
  name = "my-configuration-set"
  # Add optional settings here
  # For example, you can configure reputation metrics and other settings
  # See the AWS SES documentation for details
}

# Create an SES email identity
resource "aws_ses_email_identity" "main" {
  email = "your-email@example.com"
  # Optional: Set the email identity as a domain
  # domain = "yourdomain.com"
  
  # Configure the feedback forwarding address
  feedback_forwarding_address = "feedback@example.com"
  
  # Configure the configuration set to use for this identity
  configuration_set_name = aws_ses_configuration_set.main.name
}

# Create an SES email template
resource "aws_ses_template" "main" {
  name = "my-template"
  # Define the template content
  template = <<EOF
  <!DOCTYPE html>
  <html>
  <body>
    <h1>Welcome!</h1>
    <p>This is a test email from AWS SES.</p>
  </body>
  </html>
  EOF
  
  # Configure the template settings
  # For example, you can define subject, default values for template data, etc.
  # See the AWS SES documentation for details
}

# Send an email using SES
resource "aws_ses_send_email" "main" {
  from = "your-email@example.com"
  # Replace the recipients with your actual recipients
  destination {
    to_addresses = ["recipient1@example.com", "recipient2@example.com"]
  }
  # Set the subject of the email
  subject = "Test Email from AWS SES"
  # Use the template defined above
  template {  
    name = aws_ses_template.main.name
  }
  # Set the template data (if needed)
  # template_data = jsonencode({
  #   "name" = "John Doe"
  # })
  
  # Configure the configuration set to use for this email
  configuration_set_name = aws_ses_configuration_set.main.name
}

  