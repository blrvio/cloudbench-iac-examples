
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a BigQuery dataset
resource "google_bigquery_dataset" "main" {
  dataset_id = "my_dataset"
  # Set the location of the dataset
  location  = "US"
  # Set default partition expiration
  default_partition_expiration_ms = 31536000000 # 365 days
  # Set default table expiration
  default_table_expiration_ms = 31536000000 # 365 days
  # Set the default encryption configuration
  default_table_encryption_config {
    kms_key_name = "your-kms-key"
  }
}

# Create a BigQuery table
resource "google_bigquery_table" "main" {
  dataset_id  = google_bigquery_dataset.main.dataset_id
  table_id    = "my_table"
  description = "My BigQuery table"
  
  # Define the table schema
  schema {
    fields {
      name     = "name"
      type     = "STRING"
      mode     = "NULLABLE"
      description = "The name of the thing"
    }
    fields {
      name     = "age"
      type     = "INTEGER"
      mode     = "NULLABLE"
      description = "The age of the thing"
    }
  }
  # Set the time partition configuration
  time_partitioning {
    field        = "created_at"
    expiration_ms = 31536000000 # 365 days
    type          = "DAY"
  }
  # Set the view definition
  # view_query = "SELECT * FROM `your-project-id.my_dataset.my_other_table`"
  # Set the table encryption configuration
  # encryption_configuration {
  #   kms_key_name = "your-kms-key"
  # }
  
  # Enable view materialization
  # materialization_view {
  #   enable = true
  # }
}

# Create a BigQuery view
resource "google_bigquery_view" "main" {
  dataset_id = google_bigquery_dataset.main.dataset_id
  view_id    = "my_view"
  # Define the view query
  query = "SELECT * FROM `your-project-id.my_dataset.my_table`"
  # Set the view description
  description = "My BigQuery view"
}

# Create a BigQuery job
resource "google_bigquery_job" "main" {
  job_id      = "my_job"
  dataset_id  = google_bigquery_dataset.main.dataset_id
  job_config {
    # Set the job configuration for a query job
    query_config {
      query   = "SELECT * FROM `your-project-id.my_dataset.my_table`"
      use_legacy_sql = false # Use standard SQL
    }
    # Set the job configuration for a load job
    # load_config {
    #   source_format = "CSV"
    #   source_uris   = ["gs://your-bucket/my_data.csv"]
    #   destination_table = "your-project-id.my_dataset.my_table"
    #   create_disposition = "CREATE_IF_NEEDED"
    #   write_disposition = "WRITE_TRUNCATE"
    # }
    # Set the job configuration for an extract job
    # extract_config {
    #   source_table    = "your-project-id.my_dataset.my_table"
    #   destination_uris = ["gs://your-bucket/my_data.json"]
    #   compression = "GZIP"
    # }
    # Set the job configuration for a copy job
    # copy_config {
    #   source_table    = "your-project-id.my_dataset.my_table"
    #   destination_table = "your-project-id.my_dataset.my_other_table"
    #   write_disposition = "WRITE_TRUNCATE"
    # }
  }
}

# Create a BigQuery routine
resource "google_bigquery_routine" "main" {
  dataset_id = google_bigquery_dataset.main.dataset_id
  routine_id = "my_routine"
  # Define the routine type
  routine_type = "SCALAR_FUNCTION"
  # Define the routine language
  language      = "SQL"
  # Set the routine description
  description = "My BigQuery routine"
  # Set the routine definition
  definition = "CREATE TEMP FUNCTION my_function(x INT64) AS (x + 1)"
}

# Create a BigQuery stored procedure
resource "google_bigquery_routine" "main" {
  dataset_id = google_bigquery_dataset.main.dataset_id
  routine_id = "my_procedure"
  # Define the routine type
  routine_type = "PROCEDURE"
  # Define the routine language
  language      = "SQL"
  # Set the routine description
  description = "My BigQuery stored procedure"
  # Set the routine definition
  definition = "CREATE TEMP PROCEDURE my_procedure() AS BEGIN SELECT 'Hello World'; END"
}

  