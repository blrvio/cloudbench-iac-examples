
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon Lookout for Metrics Anomaly Detector
resource "aws_lookoutmetrics_anomaly_detector" "main" {
  anomaly_detector_name = "my-anomaly-detector"
  # Specify the dataset to use for anomaly detection
  dataset_group_name = "my-dataset-group"
  # Define the configuration for the anomaly detector
  anomaly_detector_config {
    # Configure the frequency at which anomalies are detected
    # Use the "MINUTES" or "HOURS" unit
    # Example: "MINUTES" is the default
    # Default: "MINUTES"
    # Example: "HOURS"
    # Valid values: "MINUTES", "HOURS"
    metric_frequency = "HOURS"
    # The number of time units in the metric frequency to look back for anomalies
    # Minimum: 2
    # Maximum: 168
    # Example: 24
    # Default: 24
    # Valid values: 2-168
    lookback_period_hours = 24
    # Specify the threshold for anomaly detection
    # Must be a positive number
    # Example: 2.0
    # Minimum: 0.01
    # Default: 0.05
    # Valid values: 0.01-100000
    threshold = 2.0
  }

  # Configure the tags for the anomaly detector
  tags = {
    Name = "My Anomaly Detector"
  }
}

# Create a dataset group for the anomaly detector
resource "aws_lookoutmetrics_dataset_group" "main" {
  dataset_group_name = "my-dataset-group"
  # Define the data source for the dataset group
  data_source_config {
    # Specify the configuration for an S3 data source
    s3_data_source_config {
      # Specify the S3 bucket where the data is stored
      # Example: "my-bucket"
      s3_bucket_name = "my-bucket"
      # Specify the prefix for the data in the S3 bucket
      # Example: "data/metrics"
      s3_path = "data/metrics"
      # Specify the format of the data
      # Example: "CSV"
      # Valid values: "CSV"
      s3_data_format = "CSV"
      # Specify the delimiter for the data
      # Example: ","
      # Default: ","
      # Valid values: ",", "\t"
      s3_delimiter = ","
      # Specify the header row for the data
      # Example: "FIRST"
      # Valid values: "FIRST"
      s3_header_row = "FIRST"
      # Specify the timestamp column for the data
      # Example: "timestamp"
      s3_timestamp_column = "timestamp"
      # Specify the value column for the data
      # Example: "value"
      s3_value_column = "value"
    }
  }
  # Configure the tags for the dataset group
  tags = {
    Name = "My Dataset Group"
  }
}

  