
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Marketplace subscription
resource "google_marketplace_subscription" "main" {
  name     = "your-subscription-name"
  plan     = "plan-id"
  publisher = "publisher-id"
  # Set optional configuration
  config    = <<EOF
# Configuration options go here
EOF
}

  