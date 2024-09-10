
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Cloud Video Intelligence Job
resource "google_video_intelligence_job" "default" {
  input_uri = "gs://your-bucket/your-video.mp4"
  output_uri = "gs://your-bucket/output"
  features  = ["LABEL_DETECTION"] # Possible values: [
    "LABEL_DETECTION",
    "SHOT_CHANGE_DETECTION",
    "EXPLICIT_CONTENT_DETECTION",
    "OBJECT_TRACKING",
    "FACE_DETECTION",
    "SPEECH_TRANSCRIPTION",
    "TEXT_DETECTION"
  ]
  label_detection_config {
    model = "builtin/stable"
  }
}

# Create a Google Cloud Storage Bucket
resource "google_storage_bucket" "default" {
  name    = "your-bucket"
  location = "US"
  force_destroy = true
  project  = "your-project-id"
}
  