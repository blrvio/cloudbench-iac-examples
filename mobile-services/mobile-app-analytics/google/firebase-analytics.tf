
      # Configure o provedor do Firebase
provider "google" {
  project = "your-project-id"
}

# Crie um recurso de Analytics
resource "google_firebase_analytics_app" "default" {
  app_id    = "your-app-id"
  display_name = "Your App"
}

# Defina um evento personalizado
resource "google_firebase_analytics_event" "custom_event" {
  app_id = google_firebase_analytics_app.default.app_id
  name = "custom_event_name"
  parameters {
    name  = "custom_parameter_name"
    type = "string"
  }
}
    