
    # Configure the HUAWEI CLOUD Provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create an IoT Device
resource "huaweicloud_iot_device" "main" {
  product_id     = "your-product-id" # Replace with your product ID
  device_name   = "your-device-name" # Replace with your device name
  device_secret = "your-device-secret" # Replace with your device secret
  # Optional fields
  # description = "your-description" # Replace with your description
  # tags = { Key = "your-tag-key", Value = "your-tag-value" } # Replace with your tags
}

# Create an IoT Product
resource "huaweicloud_iot_product" "main" {
  name = "your-product-name" # Replace with your product name
  # Optional fields
  # description = "your-description" # Replace with your description
  # data_model = "your-data-model" # Replace with your data model
  # tags = { Key = "your-tag-key", Value = "your-tag-value" } # Replace with your tags
}

# Create an IoT Rule
resource "huaweicloud_iot_rule" "main" {
  product_id = "your-product-id" # Replace with your product ID
  rule_name   = "your-rule-name" # Replace with your rule name
  rule_sql    = "your-rule-sql" # Replace with your rule SQL
  # Optional fields
  # description = "your-description" # Replace with your description
  # event_type = "your-event-type" # Replace with your event type
  # enabled = true # Replace with your enabled status
}

  