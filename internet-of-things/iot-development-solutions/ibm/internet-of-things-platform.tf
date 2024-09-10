
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  org_id  = "YOUR_IBM_CLOUD_ORG_ID"
}

# Create an IBM IoT Platform service
resource "ibm_iot_service" "main" {
  name = "my-iot-service"
  description = "My IoT service"
  # Optional fields:
  # tags = { /* tags */ }
  # billing_plan = "pay-as-you-go"
  # shared_secret = true
}

# Create a device type in your service
resource "ibm_iot_device_type" "main" {
  service_id = ibm_iot_service.main.id
  name = "my-device-type"
  # Optional fields:
  # description = "My device type"
  # tags = { /* tags */ }
}

# Create a device in your service
resource "ibm_iot_device" "main" {
  service_id = ibm_iot_service.main.id
  device_type = ibm_iot_device_type.main.name
  auth_type = "PSK"
  # Optional fields:
  # authentication_token = "YOUR_AUTH_TOKEN"
  # status = "active"
  # tags = { /* tags */ }
}

# Create a rule to process data from the device
resource "ibm_iot_rule" "main" {
  service_id = ibm_iot_service.main.id
  name = "my-rule"
  # Define the rule's trigger and action
  # The `trigger` must be a `device-event`
  trigger {
    type = "device-event"
    # Define the device type and event
    device_type = ibm_iot_device_type.main.name
    event_type = "temperature"
  }
  # The `action` can be a variety of types, including:
  # - `http-send`: send data to an HTTP endpoint
  # - `cloud-function`: trigger a Cloud Function
  # - `mqtt-send`: send data to an MQTT topic
  # - `cloudant-send`: send data to a Cloudant database
  action {
    type = "http-send"
    # Define the HTTP endpoint URL
    url = "https://www.example.com"
    # Optional fields:
    # headers = { /* headers */ }
    # body = "{"temperature": ${payload.temperature}}"
  }
}

  