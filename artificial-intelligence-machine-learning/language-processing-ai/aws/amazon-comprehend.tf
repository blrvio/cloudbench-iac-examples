
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um endpoint do Comprehend
resource "aws_comprehend_endpoint" "my_endpoint" {
  name         = "my-comprehend-endpoint"
  language_code = "en"
  model_arn    = "arn:aws:comprehend:us-east-1:123456789012:model/my-model"
}

# Crie um modelo de análise de sentimentos
resource "aws_comprehend_sentiment_detection_model" "my_model" {
  name       = "my-sentiment-model"
  language_code = "en"
}

# Use o endpoint do Comprehend para análise de sentimentos
resource "aws_comprehend_sentiment_detection_job" "my_job" {
  endpoint_arn = aws_comprehend_endpoint.my_endpoint.arn
  input_data_config {
    s3_uri = "s3://my-bucket/my-file.txt"
  }
  output_data_config {
    s3_uri = "s3://my-bucket/output/sentiment-results.json"
  }
  model_arn = aws_comprehend_sentiment_detection_model.my_model.arn
}

    