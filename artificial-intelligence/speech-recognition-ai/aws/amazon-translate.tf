
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a translation job
resource "aws_translate_job" "main" {
  job_name   = "my-translation-job"
  source_language_code = "en"
  target_language_code = "es"
  # Specify the input data source
  data_source {
    s3_source {
      bucket = "my-bucket"
      key    = "my-file.txt"
    }
  }
  # Configure the output data location
  data_target {
    s3_target {
      bucket = "my-output-bucket"
      key    = "my-translated-file.txt"
    }
  }
}

  