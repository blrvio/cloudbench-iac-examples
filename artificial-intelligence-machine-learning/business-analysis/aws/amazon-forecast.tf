
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um dataset de previsão
resource "aws_forecast_dataset" "my_dataset" {
  dataset_name = "my_dataset"
  dataset_type = "TARGET_TIME_SERIES"
  domain       = "RETAIL"
  data_source  = "s3://my-bucket/my-data.csv"
}

# Crie um modelo de previsão
resource "aws_forecast_predictor" "my_predictor" {
  predictor_name = "my_predictor"
  algorithm_arn  = "arn:aws:forecast:us-east-1:123456789012:algorithm/my-algorithm"
  forecast_horizon = 14
  forecast_types   = ["MEAN"]
  dataset_group_arn = aws_forecast_dataset_group.my_dataset_group.arn
}

# Crie um grupo de datasets
resource "aws_forecast_dataset_group" "my_dataset_group" {
  dataset_group_name = "my_dataset_group"
  datasets = [aws_forecast_dataset.my_dataset.id]
}

# Gere previsões
resource "aws_forecast_forecast" "my_forecast" {
  forecast_name = "my_forecast"
  predictor_arn   = aws_forecast_predictor.my_predictor.arn
}

# Crie um recurso de dados de previsão
resource "aws_forecast_data_source" "my_data_source" {
  data_source_name = "my_data_source"
  data_source_type = "S3"
  file_path        = "s3://my-bucket/my-data.csv"
}

# Crie um recurso de algoritmo de previsão
resource "aws_forecast_algorithm" "my_algorithm" {
  algorithm_name = "my_algorithm"
  algorithm_type = "ARIMA"
}

    