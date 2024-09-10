
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Firebase project
resource "google_firebase_project" "default" {
  project_id = "your-firebase-project-id"
  name        = "your-firebase-project-name"
}

# Create a Firebase Analytics app
resource "google_firebase_analytics_app" "default" {
  project        = google_firebase_project.default.project_id
  app_id         = "your-analytics-app-id"
  display_name = "Your Analytics App Name"
}

# Create a Firebase Analytics web app
resource "google_firebase_analytics_webapp" "default" {
  project   = google_firebase_project.default.project_id
  app_id    = google_firebase_analytics_app.default.app_id
  web_app_id = "your-web-app-id"
  name       = "your-web-app-name"
}

# Create a Firebase Analytics iOS app
resource "google_firebase_analytics_ios_app" "default" {
  project  = google_firebase_project.default.project_id
  app_id   = google_firebase_analytics_app.default.app_id
  bundle_id = "your-bundle-id"
  name      = "your-ios-app-name"
}

# Create a Firebase Analytics Android app
resource "google_firebase_analytics_android_app" "default" {
  project     = google_firebase_project.default.project_id
  app_id      = google_firebase_analytics_app.default.app_id
  package_name = "your-package-name"
  name         = "your-android-app-name"
}

  