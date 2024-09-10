
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create an IBM IoT Platform service
resource "ibm_iot_platform" "main" {
  name        = "my-iot-platform"
  organization = "my-organization"
  # Optional: Set the pricing plan
  # pricing_plan = "lite"
  # Optional: Set the region
  # region = "us-south"
}

# Create a device type
resource "ibm_iot_platform_device_type" "main" {
  name       = "my-device-type"
  platform_id = ibm_iot_platform.main.id
  # Optional: Set the description
  # description = "My device type description"
}

# Create a device
resource "ibm_iot_platform_device" "main" {
  name         = "my-device"
  device_type_id = ibm_iot_platform_device_type.main.id
  # Optional: Set the authentication type
  # auth_type = "token"
  # Optional: Set the authentication token
  # auth_token = "your-auth-token"
}

# Create a rule
resource "ibm_iot_platform_rule" "main" {
  name         = "my-rule"
  platform_id = ibm_iot_platform.main.id
  # Define the rule's action
  action {
    # Send data to an HTTP endpoint
    http {
      method = "POST"
      url    = "https://example.com/data"
    }
  }
  # Define the rule's condition
  condition {
    type = "event"
    # Filter events based on the device type
    device_type = ibm_iot_platform_device_type.main.name
  }
}

  