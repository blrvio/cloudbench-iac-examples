
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create an API Key
resource "google_api_key" "main" {
  name        = "my-api-key"
  display_name = "API Key for API Monetization"
  # Set the restrictions for the API Key
  restrictions {
    # Allow access to specific APIs
    api_allowed_list = ["your-api-name.googleapis.com"]
  }
}

# Create a Billing Account
resource "google_billing_account" "main" {
  display_name  = "My Billing Account"
  name          = "my-billing-account"
  # Set the billing account properties
  # See the Google Cloud documentation for more information
  # https://cloud.google.com/billing/docs/
}

# Create an API Monetization Plan
resource "google_api_monetization_plan" "main" {
  name           = "my-api-monetization-plan"
  billing_account = google_billing_account.main.name
  # Set the pricing model
  # See the Google Cloud documentation for more information
  # https://cloud.google.com/api-monetization/docs/
}

# Associate the API Key with the API Monetization Plan
resource "google_api_monetization_plan_key" "main" {
  api_key    = google_api_key.main.name
  plan_name = google_api_monetization_plan.main.name
}

  