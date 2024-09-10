
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Firebase Cloud Messaging Server Key
resource "google_firebase_messaging_server_key" "main" {
  app_id = "your-firebase-app-id"
  name = "your-server-key-name"
}

# Example sending an FCM message using the Server Key
resource "google_firebase_messaging_message" "main" {
  server_key = google_firebase_messaging_server_key.main.server_key
  # Define the message payload
  message {
    token = "your-device-token"
    notification {
      title = "FCM Message"
      body  = "This is a test message from Terraform"
    }
  }
}
  