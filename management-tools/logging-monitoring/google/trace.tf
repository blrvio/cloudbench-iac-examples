
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Replace with your desired region
}

# Create a Trace Span
resource "google_trace_span" "main" {
  name    = "my-trace-span"
  parent  = "projects/your-gcp-project-id/traces/12345678901234567890"
  span_id = "12345678901234567890"
  # Optional: Customize the span's attributes
  attributes {
    key   = "http.method"
    value = "GET"
  }
}

# Create a Trace Tracepoint
resource "google_trace_tracepoint" "main" {
  name         = "my-tracepoint"
  display_name = "My Tracepoint"
  # Optional: Configure custom labels
  labels {
    key   = "environment"
    value = "production"
  }
  # Optional: Configure filtering criteria
  filter {
    attribute_key   = "http.method"
    attribute_value = "GET"
    operator       = "EQUALS"
  }
}

  