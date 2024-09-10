
    # Configure the Google Cloud provider
provider "google" {
  project  = "your-project-id"
  region   = "us-central1"
  zone     = "us-central1-a"
}

# Create a Cloud Debugger configuration
resource "google_debugger_config" "default" {
  location = "us-central1"

  # Enable the Debugger for your project.
  enabled  = true

  # Configure the default settings for debugging.
  debuggee_config {
    agent_version    = "latest"
    project          = "your-project-id"
    sampling_strategy = "PROBABILITY_SAMPLING"
    sampling_ratio    = 0.05
    # Optionally specify the language of your code.
    # language = "PYTHON"
  }
}

  