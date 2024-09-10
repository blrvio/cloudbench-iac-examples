
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Forecast Dataset
resource "aws_forecast_dataset" "main" {
  dataset_name = "my-forecast-dataset"
  dataset_type = "TARGET_TIME_SERIES"
  domain         = "RETAIL"
  data_frequency = "D" # Daily frequency
  schema         = <<EOF
    { "TARGET_VALUE": "FLOAT", "timestamp": "TIMESTAMP" }
  EOF

  # Configure the dataset import job
  dataset_import_job {
    data_source {
      s3_config {
        path = "s3://my-bucket/data/forecast.csv"
      }
    }
  }
}

# Create a Forecast Dataset Group
resource "aws_forecast_dataset_group" "main" {
  dataset_group_name = "my-forecast-dataset-group"
  domain              = "RETAIL"
  # Add the dataset to the group
  datasets = [aws_forecast_dataset.main.dataset_arn]
}

# Create a Forecast Predictor
resource "aws_forecast_predictor" "main" {
  predictor_name = "my-forecast-predictor"
  forecast_horizon  = 14
  forecast_types = ["TARGET_VALUE"]
  # Use the dataset group for the predictor
  dataset_group_arn = aws_forecast_dataset_group.main.dataset_group_arn
  # Configure the performance metrics for the predictor
  performance_metrics {
    metric_name   = "RMSE"
    metric_value  = 0.1
  }
}

# Create a Forecast
resource "aws_forecast_forecast" "main" {
  forecast_name = "my-forecast"
  predictor_arn = aws_forecast_predictor.main.predictor_arn
  # Configure the forecast frequency
  forecast_frequency = "D"
  # Set the start and end dates for the forecast
  start_date = "2023-12-01"
  end_date   = "2023-12-31"
}

  