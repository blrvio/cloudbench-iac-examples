
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um job de transcrição
resource "aws_transcribe_job" "my_job" {
  job_name     = "my_job"
  transcription_job_status = "IN_PROGRESS"
  language_code = "en-US"
  media {
    media_file_uri = "s3://my-bucket/my-audio-file.mp3"
  }
  settings {
    show_speaker_labels = true
    max_speaker_labels = 10
  }
}

# Obtenha o resultado da transcrição
output "transcription_result" {
  value = aws_transcribe_job.my_job.results_uri
}
    