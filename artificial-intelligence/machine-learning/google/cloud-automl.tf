
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud AutoML Model
resource "google_automl_model" "my_model" {
  display_name    = "my-automl-model"
  dataset_id      = "your-dataset-id"
  prediction_type = "image_classification"
  # Optional configuration
  # deployment_state = "DEPLOYED"
  # model_type = "CLOUD"
}

# Create a Cloud AutoML Dataset
resource "google_automl_dataset" "my_dataset" {
  display_name = "my-automl-dataset"
  dataset_type = "IMAGE_OBJECT_DETECTION"
}

# Create a Cloud AutoML Dataset Item
resource "google_automl_dataset_item" "my_dataset_item" {
  dataset_id = google_automl_dataset.my_dataset.id
  # Set appropriate values for the dataset type
  # Example for image classification:
  # image_classification { content = "your-image-data" }
}

  