
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "default"
}

# Create an IoT Platform instance
resource "alicloud_iot_instance" "main" {
  name = "my-iot-instance"
  type = "standard"
}

# Create an IoT product
resource "alicloud_iot_product" "main" {
  instance_id = alicloud_iot_instance.main.id
  name        = "my-iot-product"
  product_type = "custom"
}

# Create an IoT device
resource "alicloud_iot_device" "main" {
  instance_id = alicloud_iot_instance.main.id
  product_key  = alicloud_iot_product.main.product_key
  device_name = "my-iot-device"
  # Set the device's initial status
  status = "online"
}

# Create an IoT rule
resource "alicloud_iot_rule" "main" {
  instance_id = alicloud_iot_instance.main.id
  name         = "my-iot-rule"
  rule_desc   = "Example IoT rule"
  # Define the rule's actions
  rule_actions = <<EOF
  [
    {
      "actionType": "function",
      "actionParams": {
        "funcId": "your-function-id"
      }
    }
  ]
  EOF
  # Define the rule's triggering condition
  rule_condition = <<EOF
  {
    "conditionType": "deviceStatus",
    "conditionParams": {
      "deviceStatus": "online"
    }
  }
  EOF
}

# Create an IoT topic
resource "alicloud_iot_topic" "main" {
  instance_id = alicloud_iot_instance.main.id
  name         = "my-iot-topic"
  # Set the topic's maximum message size
  max_message_size = 1024
  # Set the topic's message retention period
  message_retention_period = 86400
}

  