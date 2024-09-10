
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Replace with your desired region
}

# Define a Cloud Datastore Entity
resource "google_datastore_entity" "my_entity" {
  kind = "MyEntity"
  key {
    partition_id {
      project_id = google_project.default.project_id
    }
    path {
      kind = "MyEntity"
      name = "my_entity_name"
    }
  }
  properties {
    "name" = "My Entity"
    "description" = "This is an example entity"
  }
}

# Create a Google Project (optional, only if you don't have one already)
resource "google_project" "default" {
  project_id = "your-gcp-project-id"
  org_id      = "your-gcp-org-id"
  name        = "Your GCP Project Name"
}

# This is just an example and might require adjustments depending on your specific use case
# For more advanced usage, refer to the Terraform documentation for Cloud Datastore: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/datastore_entity

  