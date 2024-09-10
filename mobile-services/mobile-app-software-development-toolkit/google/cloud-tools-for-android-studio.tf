
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1" # Choose a region for your resources
}

# Define a Cloud Tools for Android Studio configuration
resource "google_android_studio_configuration" "main" {
  name     = "my-android-studio-config"
  location = google_android_studio_location.main.name
  # Example configuration with Cloud Emulator
  emulator_config {
    emulator_image_id  = "google_android_studio_emulator_image.main.emulator_image_id"
    device_model    = "Pixel 4"
    device_orientation = "portrait"
  }
  # Configure for Firebase
  firebase_config {
    #  Configure your Firebase project
    project_id = "your-firebase-project-id"
  }
  # Configure for Cloud Run
  cloud_run_config {
    #  Enable deploying to Cloud Run
    enable_cloud_run_deployment = true
    #  Configure your Cloud Run service name
    service_name = "my-cloud-run-service"
  }
}

# Define a Cloud Tools for Android Studio location
resource "google_android_studio_location" "main" {
  name = "my-android-studio-location"
  location = "us-central1" # Choose a region for your resources
}

# Define a Cloud Tools for Android Studio emulator image
resource "google_android_studio_emulator_image" "main" {
  name = "my-emulator-image"
  location = google_android_studio_location.main.name
  # Choose an Android system image
  android_system_image_id = "android-28"
  # Choose an Android API level
  api_level = "28"
}

  