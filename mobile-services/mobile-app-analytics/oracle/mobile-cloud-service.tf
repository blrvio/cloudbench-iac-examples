
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your desired region
}

# Create a Mobile Hub
resource "oci_mobile_hub" "main" {
  name     = "my-mobile-hub"
  # Replace with your desired name
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7xxxxxxxxxxxxx"
  # Replace with your compartment ID
}

# Create a Mobile Backend Service
resource "oci_mobile_backend_service" "main" {
  mobile_hub_id = oci_mobile_hub.main.id
  name           = "my-backend-service"
  # Replace with your desired name
  description     = "Backend service for my mobile app"
  # Replace with your desired description
}

# Create a Mobile Push Notification Channel
resource "oci_mobile_push_notification_channel" "main" {
  mobile_hub_id  = oci_mobile_hub.main.id
  mobile_backend_service_id = oci_mobile_backend_service.main.id
  name            = "my-push-notification-channel"
  # Replace with your desired name
  type            = "FCM"
  # Replace with your desired type (FCM, APNS, etc.)
  # Replace with your notification configuration
  # (e.g., FCM API Key, APNS certificate, etc.)
  config         = "your-notification-config"
}

# Create a Mobile Analytics Service
resource "oci_mobile_analytics_service" "main" {
  mobile_hub_id = oci_mobile_hub.main.id
  name           = "my-analytics-service"
  # Replace with your desired name
  description     = "Analytics service for my mobile app"
  # Replace with your desired description
}

  