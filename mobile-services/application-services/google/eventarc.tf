
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create an Eventarc Trigger
resource "google_eventarc_trigger" "example" {
  name       = "my-trigger"
  location   = "us-central1"
  event_type = "google.cloud.storage.object.v1.finalized"

  trigger {
    # Event filter for the trigger
    event_filters {
      attribute  = "bucket"
      value      = "your-bucket-name"
      operator    = "="
    }
    # Endpoint to which the event will be sent
    destination_endpoint {
      cloud_function {
        function_ref = "projects/your-gcp-project-id/locations/us-central1/functions/your-cloud-function"
      }
    }
  }
}

  