
    terraform { required_providers {
  google = {
    source  = "hashicorp/google"
    version = "~> 4.0"
  }
}
}

provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

resource "google_vertex_ai_endpoint" "my_endpoint" {
  display_name = "my_endpoint"
  location     = "us-central1"
  project      = "gcp-project-id"
  machine_spec {
    machine_type = "n1-standard-1"
    accelerator_type = "NVIDIA_TESLA_T4"
  }

  # Define a model to be deployed on the endpoint
  deployed_models {
    model = google_vertex_ai_model.my_model.name
    initial_instance_count = 1
    min_replica_count      = 1
    max_replica_count      = 10
  }
}

resource "google_vertex_ai_model" "my_model" {
  display_name = "my_model"
  location     = "us-central1"
  project      = "gcp-project-id"

  # Define the container image for the model
  container_spec {
    image = "us-docker.pkg.dev/cloud-aiplatform/release/1.16.0/vertex-ai-sdk"
  }

  # Define the model's runtime version
  version {
    runtime_version = "1.16.0"
  }
}

resource "google_storage_bucket" "my_bucket" {
  name     = "my-bucket"
  location = "US"
  force_destroy = true
}

resource "google_storage_bucket_object" "my_model_file" {
  bucket = google_storage_bucket.my_bucket.name
  name   = "my_model.tar.gz"
  source = "path/to/my_model.tar.gz"
}

  