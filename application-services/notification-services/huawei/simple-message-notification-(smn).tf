
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create an SMN topic
resource "huaweicloud_smn_topic" "main" {
  name     = "my-smn-topic"
  # Optional: Set the access control list
  acl = "public"
}

# Create an SMN subscription
resource "huaweicloud_smn_subscription" "main" {
  topic_arn  = huaweicloud_smn_topic.main.arn
  endpoint   = "http://example.com/receive_message"
  protocol   = "http"
  # Optional: Set the subscription type
  type       = "push"
  # Optional: Set the filter policy
  filter_policy = "{"tag":"tagValue"}"
}

# Send a message to the SMN topic
resource "huaweicloud_smn_message" "main" {
  topic_arn = huaweicloud_smn_topic.main.arn
  message   = "Hello from Terraform"
  # Optional: Set the message attributes
  message_attributes = {
    "key" = "value"
  }
}
  