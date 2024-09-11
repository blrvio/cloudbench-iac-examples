
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region  = "us-east-1"  # Replace with your desired region
  # Add your access key and secret key here
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
}

# Create a Direct Mail template
resource "alicloud_directmail_template" "main" {
  name     = "My Direct Mail Template"
  subject  = "Welcome to our website"
  content  = "Welcome to our website!" # Replace with your desired content
  from_type = "normal"
  from_name = "My Website"
}

# Create a Direct Mail account
resource "alicloud_directmail_account" "main" {
  name = "My Direct Mail Account"
}

# Send a Direct Mail message
resource "alicloud_directmail_send" "main" {
  account_id      = alicloud_directmail_account.main.id
  template_id     = alicloud_directmail_template.main.id
  # Replace with your desired recipient address
  address        = "recipient@example.com"
  sender_name   = "My Website"
  reply_to_address = "replyto@example.com"
}

  