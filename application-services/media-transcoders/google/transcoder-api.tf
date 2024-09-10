
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Storage bucket for input and output files
resource "google_storage_bucket" "transcoder_bucket" {
  name     = "transcoder-input-output"
  location = "US"
  force_destroy = true
}

# Create a Transcoder job template
resource "google_transcoder_job_template" "main" {
  name = "my-job-template"
  config {
    input {
      uri = "gs://transcoder-input-output/input.mp4"
    }
    output {
      uri  = "gs://transcoder-input-output/output.mp4"
      preset {
        name = "preset/h264/1080p"
      }
    }
  }
}

# Create a Transcoder job
resource "google_transcoder_job" "main" {
  name = "my-transcoder-job"
  template_id = google_transcoder_job_template.main.id
  input_uri = "gs://transcoder-input-output/input.mp4"
  output_uri = "gs://transcoder-input-output/output.mp4"
}

  