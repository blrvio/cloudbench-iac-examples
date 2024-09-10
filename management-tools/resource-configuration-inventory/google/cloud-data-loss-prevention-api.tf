
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a DLP job
resource "google_dlp_job" "inspect" {
  display_name = "inspect-job"
  job_type     = "INSPECT"
  inspect_job {
    inspect_config {
      info_types {
        name = "EMAIL_ADDRESS"
      }
      include_quote {
        # Include only the quote contents in the results.
        # If this is set to false, the entire matching element
        # (for example, a sentence) will be returned.
        include_quote = true
      }
    }
    storage_config {
      datastore {
        # Use Cloud Storage
        datastore_type = "CLOUD_STORAGE"
        table {
          # Path to your Cloud Storage bucket
          # Must be a fully qualified Google Cloud Storage URI
          # e.g. gs://your-bucket/your-file.csv
          path = "gs://your-bucket/your-file.csv"
        }
      }
    }
    inspect_template_name = "your-inspect-template-name"
  }
}

# Create a DLP inspect template
resource "google_dlp_inspect_template" "template" {
  display_name = "inspect-template"
  inspect_config {
    info_types {
      name = "EMAIL_ADDRESS"
    }
    include_quote {
      # Include only the quote contents in the results.
      # If this is set to false, the entire matching element
      # (for example, a sentence) will be returned.
      include_quote = true
    }
  }
}
  