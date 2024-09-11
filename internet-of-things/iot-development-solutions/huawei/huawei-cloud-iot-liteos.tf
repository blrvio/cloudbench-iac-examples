
    # Configure the HUAWEI Cloud provider
provider "huaweicloud" {
  # Replace with your HUAWEI Cloud region
  region = "cn-north-1"
}

# Create an IoT LiteOS device
resource "huaweicloud_iotl_device" "main" {
  device_name = "my-device"
  # Replace with the device type
  device_type = "temperature_sensor"
  # Replace with the device secret
  secret = "my-device-secret"
  # Replace with the device owner
  owner = "my-owner"
}

# Create a device shadow
resource "huaweicloud_iotl_device_shadow" "main" {
  device_name = huaweicloud_iotl_device.main.device_name
  # Replace with the device shadow name
  name = "my-device-shadow"
  # Replace with the desired state
  desired_state = {
    temperature = 25
  }
  # Replace with the reported state
  reported_state = {
    temperature = 23
  }
}

# Create a data stream
resource "huaweicloud_iotl_data_stream" "main" {
  device_name = huaweicloud_iotl_device.main.device_name
  # Replace with the data stream name
  name = "my-data-stream"
  # Replace with the data stream type
  type = "temperature"
}

# Create a rule
resource "huaweicloud_iotl_rule" "main" {
  # Replace with the rule name
  name = "my-rule"
  # Replace with the rule description
  description = "Alert if temperature exceeds 30"
  # Replace with the rule SQL statement
  sql = "SELECT * FROM my-data-stream WHERE temperature > 30"
  # Replace with the action to take
  action = "send_notification"
}

# Create a notification
resource "huaweicloud_iotl_notification" "main" {
  # Replace with the notification name
  name = "my-notification"
  # Replace with the notification target
  target = "email"
  # Replace with the notification message
  message = "Temperature alert: {{temperature}}"
}

  