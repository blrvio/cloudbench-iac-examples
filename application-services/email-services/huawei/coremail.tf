
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  # Replace with your region
  region = "cn-north-1"
}

# Create a CoreMail account
resource "huaweicloud_coremail_account" "main" {
  account_name = "my-coremail-account"
  # Replace with your desired email domain
  domain_name = "example.com"
  # Enable email verification
  verify_domain_email = true
}

# Create a mailbox for the CoreMail account
resource "huaweicloud_coremail_mailbox" "main" {
  account_id = huaweicloud_coremail_account.main.id
  mailbox_name = "john.doe"
  # Replace with the desired password
  password = "password123"
  # Enable mailbox quota
  quota = 1024
  # Replace with your desired email address
  email_address = "john.doe@example.com"
  # Enable forwarding email address
  forward_to = "john.doe@example.net"
  # Define the mailbox type
  type = "standard"
}

  