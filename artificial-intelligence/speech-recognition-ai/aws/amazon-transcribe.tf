
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon Transcribe job
resource "aws_transcribe_job" "main" {
  job_name   = "my-transcribe-job"
  media {
    media_file_uri = "s3://my-bucket/my-audio-file.mp3"
  }
  language_code = "en-US"
  # Optional settings
  # transcript_config {
  #   # Enable custom vocabulary
  #   vocabulary_name = "my-vocabulary"
  # }
  # settings {
  #   # Enable speaker identification
  #   show_speaker_labels = true
  # }
}

# (Optional) Create a custom vocabulary
# resource "aws_transcribe_vocabulary" "main" {
#  vocabulary_name = "my-vocabulary"
#  language_code   = "en-US"
#  vocabulary_file_uri = "s3://my-bucket/my-vocabulary.txt"
# }
  