
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create a SMS app
resource "huaweicloud_msgsms_app" "main" {
  name = "my-sms-app"
  # Configure the SMS app's notification settings
  notification_config {
    # Configure Slack notification parameters
    slack {
      channel = "my-slack-channel" # Slack channel name
      webhook_url = "https://hooks.slack.com/services/..."
    }
  }
}

# Create an SMS template
resource "huaweicloud_msgsms_template" "main" {
  app_id = huaweicloud_msgsms_app.main.id
  name = "my-sms-template"
  template_content = "Hello, [name]! This is a test message."
  # Set the template type
  template_type = "MARKETING"
}

# Send an SMS message
resource "huaweicloud_msgsms_send_sms" "main" {
  app_id = huaweicloud_msgsms_app.main.id
  template_id = huaweicloud_msgsms_template.main.id
  # Set the recipient's phone number
  phone_number = "1234567890"
  # Define the template parameters
  template_params = {
    name = "John Doe"
  }
}

  