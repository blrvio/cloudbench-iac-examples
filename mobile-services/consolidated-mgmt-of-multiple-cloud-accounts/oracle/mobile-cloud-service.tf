
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud region
}

# Create a Mobile Backend Service
resource "oci_mobile_backend_service" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7677777777777777777777777777777"
  # Replace with your compartment ID
  name = "my-mobile-backend-service"
  display_name = "My Mobile Backend Service"
  # Define the service's configuration
  config = <<EOF
{
  "apiVersion": "v1",
  "kind": "MobileBackendService",
  "metadata": {
    "name": "my-mobile-backend-service"
  },
  "spec": {
    "pushNotifications": {
      "providers": [
        {
          "name": "fcm",
          "credentials": {
            "apiKey": "YOUR_FCM_API_KEY"
            # Replace with your Firebase Cloud Messaging API Key
          }
        }
      ]
    }
  }
}
EOF
}

# Create a Mobile Backend Application
resource "oci_mobile_backend_application" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7677777777777777777777777777777"
  # Replace with your compartment ID
  mobile_backend_service_id = oci_mobile_backend_service.main.id
  name = "my-mobile-backend-app"
  display_name = "My Mobile Backend Application"
}

  