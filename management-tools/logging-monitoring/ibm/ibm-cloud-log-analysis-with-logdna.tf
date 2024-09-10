
    # Configure the IBM Cloud provider
provider "ibm" {
  # Replace with your IBM Cloud API key
  api_key = "YOUR_API_KEY"
  # Replace with your IBM Cloud region
  region  = "us-south"
}

# Create a LogDNA Ingestion Key
resource "ibm_logdna_ingestion_key" "main" {
  # Replace with your desired Ingestion Key name
  name = "my-ingestion-key"
  # Optional: Set a custom description for the Ingestion Key
  description = "My ingestion key for LogDNA"
}

# Create a LogDNA Log Stream
resource "ibm_logdna_log_stream" "main" {
  # Replace with your desired Log Stream name
  name = "my-log-stream"
  # Replace with your LogDNA Ingestion Key ID
  ingestion_key_id = ibm_logdna_ingestion_key.main.id
  # Optional: Set a custom description for the Log Stream
  description = "My log stream for LogDNA"
}

# Create a LogDNA Log Source
resource "ibm_logdna_log_source" "main" {
  # Replace with your desired Log Source name
  name = "my-log-source"
  # Replace with your LogDNA Log Stream ID
  log_stream_id = ibm_logdna_log_stream.main.id
  # Optional: Set a custom description for the Log Source
  description = "My log source for LogDNA"
}

# Create a LogDNA Log Filter
resource "ibm_logdna_log_filter" "main" {
  # Replace with your desired Log Filter name
  name = "my-log-filter"
  # Replace with your LogDNA Log Stream ID
  log_stream_id = ibm_logdna_log_stream.main.id
  # Replace with your desired filter expression
  filter_expression = "level=error"
  # Optional: Set a custom description for the Log Filter
  description = "My log filter for LogDNA"
}

  