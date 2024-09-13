
      # Configure o provedor do Google Cloud
provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}

# Crie uma função do Cloud Functions
resource "google_cloudfunctions2_function" "hello_world" {
  name     = "hello-world"
  runtime  = "nodejs16"
  entry_point = "helloWorld"
  source_archive_bucket = "my-bucket"
  source_archive_object = "hello-world.zip"
  trigger_http = true
}

    