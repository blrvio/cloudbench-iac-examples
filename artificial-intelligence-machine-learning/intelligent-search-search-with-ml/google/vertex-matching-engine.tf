
    # Configure the Google Cloud Provider
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Create a Vertex AI Matching Engine Index
resource "google_vertex_ai_matching_engine_index" "main" {
  name     = "my-matching-engine-index"
  location = google_vertex_ai_matching_engine_index.main.location
  # Define the Matching Engine's features
  matching_engine_features {
    feature {
      feature_id = "user_id"
      type        = "INT64"
    }
    feature {
      feature_id = "item_id"
      type        = "INT64"
    }
  }
  # Define the Matching Engine's distance metric
  distance_metric {
    metric = "COSINE"
  }
  # Define the Matching Engine's deployment
  deployment {
    dedicated_resources {
      machine_type = "n1-standard-1"
      # Specify the number of replicas of the Matching Engine
      replica_count = 1
    }
  }
}

# Create a Vertex AI Matching Engine Dataset
resource "google_vertex_ai_matching_engine_dataset" "main" {
  name     = "my-matching-engine-dataset"
  location = google_vertex_ai_matching_engine_index.main.location
  # Define the Matching Engine's dataset's source
  dataset_source {
    # Option 1: Use an existing BigQuery table as the source
    bigquery_source {
      table = "my-project.my-dataset.my-table"
    }
    # Option 2: Use a local file as the source
    # local_source {
    #   path  = "path/to/local/file"
    #   format = "CSV"
    # }
  }
}

# Create a Vertex AI Matching Engine Featurestore
resource "google_vertex_ai_matching_engine_featurestore" "main" {
  name     = "my-matching-engine-featurestore"
  location = google_vertex_ai_matching_engine_index.main.location
  # Define the Matching Engine's featurestore's features
  features {
    feature {
      feature_id = "user_id"
      type        = "INT64"
    }
    feature {
      feature_id = "item_id"
      type        = "INT64"
    }
  }
}

# Create a Vertex AI Matching Engine Featurestore Online Serving Config
resource "google_vertex_ai_matching_engine_featurestore_online_serving_config" "main" {
  name     = "my-matching-engine-featurestore-online-serving-config"
  location = google_vertex_ai_matching_engine_index.main.location
  # Define the Matching Engine's featurestore's online serving configuration
  online_serving_config {
    # Specify the number of replicas of the online serving instance
    replica_count = 1
  }
}

  