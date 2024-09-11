
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
  # Credentials can be configured in the provider block or as environment variables
  # Refer to the official documentation for more information
  # https://www.terraform.io/docs/providers/alicloud/index.html
}

# Create an SMS Sign
resource "alicloud_sms_sign" "default" {
  sign_name = "My Company Sign" # Replace with your desired sign name
  sign_type = "ENTERPRISE" # Specify the sign type (ENTERPRISE or PERSONAL)
  # Optional fields
  #  description = "Sign description"
  #  category = "FINANCE"
  #  tags = {
  #    key1 = "value1"
  #    key2 = "value2"
  #  }
}

# Create an SMS Template
resource "alicloud_sms_template" "default" {
  template_name = "My SMS Template" # Replace with your desired template name
  template_code = "SMS_18000000" # Replace with your desired template code
  template_content = "Your code is: {code}" # Replace with your desired template content
  # Optional fields
  #  description = "Template description"
  #  tags = {
  #    key1 = "value1"
  #    key2 = "value2"
  #  }
}

# Send an SMS message
resource "alicloud_sms_send_sms" "default" {
  phone_numbers = ["13800000000"] # Replace with the recipient phone number
  sign_name      = alicloud_sms_sign.default.sign_name
  template_code  = alicloud_sms_template.default.template_code
  # Optional fields
  #  template_param = {
  #    code = "123456"
  #  }
  #  out_id = "123456"
  #  from_param = "123456"
}

  