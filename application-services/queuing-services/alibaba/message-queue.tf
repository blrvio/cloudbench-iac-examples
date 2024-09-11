
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou"
}

# Create an MNS queue
resource "alicloud_mns_queue" "example" {
  name           = "my-queue"
  queue_name      = "my-queue"
  logging_enabled = true
}

# Create an MNS topic
resource "alicloud_mns_topic" "example" {
  name           = "my-topic"
  topic_name      = "my-topic"
  logging_enabled = true
}

# Create an MNS subscription
resource "alicloud_mns_subscription" "example" {
  endpoint       = "http://${alicloud_mns_topic.example.endpoint}"
  topic_name    = "my-topic"
  subscription_name = "my-subscription"
  message_filter = "{"type": "json", "filter": "{"tag":"my-tag"}"}"
  # Optional: Specify the maximum number of retry attempts for failed message redelivery
  # max_receive_count = 10
}

# Create an MNS message
resource "alicloud_mns_message" "example" {
  queue_name = "my-queue"
  message_body = "{"key":"value"}"
}

  