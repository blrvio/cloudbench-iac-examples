
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Data Fusion instance
resource "google_data_fusion_instance" "default" {
  name     = "my-data-fusion-instance"
  location = "us-central1"
  # Specify the version of Cloud Data Fusion
  version = "latest"
  # Configure the instance
  config {
    # Choose a machine type
    machine_type = "n1-standard-1"
    # Define the network configuration
    network_config {
      # Specify the network to use
      network = "projects/your-gcp-project-id/global/networks/default"
    }
  }
}

# Create a Cloud Data Fusion pipeline
resource "google_data_fusion_pipeline" "default" {
  instance = google_data_fusion_instance.default.name
  name     = "my-pipeline"
  # Specify the pipeline's source and destination
  source_config {
    # Example: Read data from Cloud Storage
    type = "GCS"
    # Replace with your actual Cloud Storage bucket name and object
    uri  = "gs://my-bucket/my-file.csv"
  }
  destination_config {
    # Example: Write data to BigQuery
    type = "BIGQUERY"
    # Replace with your actual BigQuery dataset and table name
    uri  = "projects/your-gcp-project-id/datasets/my-dataset/tables/my-table"
  }
  # Define the pipeline's transformation logic
  # This is a basic example using a SQL transformation
  transform_config {
    # Specify the transformation language
    language = "SQL"
    # Write your SQL query
    script = "SELECT * FROM my-file.csv"
  }
}

  