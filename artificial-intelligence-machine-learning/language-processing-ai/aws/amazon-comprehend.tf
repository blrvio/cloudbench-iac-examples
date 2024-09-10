
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon Comprehend Language Detector
resource "aws_comprehend_entity_recognizer" "main" {
  name         = "my-entity-recognizer"
  data_source  = "S3"
  data_source_config {
    s3_uri = "s3://my-bucket/my-data.csv"
  }
  language_code = "en"
  # Optionally configure the training parameters
  # training_parameters {
  #   # Add training parameters here if needed
  # }
}

# Create an Amazon Comprehend Sentiment Detection Job
resource "aws_comprehend_sentiment_detection_job" "main" {
  job_name   = "my-sentiment-job"
  data_source = "S3"
  data_source_config {
    s3_uri = "s3://my-bucket/my-text-data.txt"
  }
  language_code = "en"
  # Optional settings
  #  output_data_config {
  #    s3_uri = "s3://my-bucket/output"
  #  }
}

# Create an Amazon Comprehend Key Phrase Extraction Job
resource "aws_comprehend_key_phrases_detection_job" "main" {
  job_name   = "my-key-phrase-job"
  data_source = "S3"
  data_source_config {
    s3_uri = "s3://my-bucket/my-text-data.txt"
  }
  language_code = "en"
  # Optional settings
  # output_data_config {
  #    s3_uri = "s3://my-bucket/output"
  #  }
}

# Create an Amazon Comprehend Entity Recognition Job
resource "aws_comprehend_entity_recognition_job" "main" {
  job_name   = "my-entity-recognition-job"
  data_source = "S3"
  data_source_config {
    s3_uri = "s3://my-bucket/my-text-data.txt"
  }
  language_code = "en"
  # Optional settings
  # output_data_config {
  #    s3_uri = "s3://my-bucket/output"
  #  }
  # entity_recognizer_arn = aws_comprehend_entity_recognizer.main.arn
}

  