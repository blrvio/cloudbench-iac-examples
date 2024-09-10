
    # Configure the SendGrid provider
provider "sendgrid" {
  api_key = "YOUR_SENDGRID_API_KEY"
}

# Create a SendGrid email template
resource "sendgrid_template" "main" {
  name = "my-template"
  # Use a template from the SendGrid API
  template_id = "YOUR_TEMPLATE_ID"
}

# Create a SendGrid email sending job
resource "sendgrid_mail" "main" {
  from_email  = "from@example.com"
  to_emails = ["to@example.com"]
  subject     = "My SendGrid Email"
  # Use the created template
  template_id = sendgrid_template.main.template_id
  # Define the template data
  dynamic "template_data" {
    for_each = { "name" = "John Doe", "age" = 30 }
    content {
      value = template_data.value
    }
  }
}

  