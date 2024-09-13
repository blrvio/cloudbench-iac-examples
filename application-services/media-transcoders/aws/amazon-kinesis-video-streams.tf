
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um stream de vídeo Kinesis
resource "aws_kinesisvideo_stream" "example" {
  data_retention_in_hours = 12
  name                     = "example-stream"
  tags                     = {
    Name = "example-stream"
  }
}

# Crie um endpoint de gravação para o stream
resource "aws_kinesisvideo_stream_recording_endpoint" "example" {
  stream_name = aws_kinesisvideo_stream.example.name
}

# Crie um endpoint de reprodução para o stream
resource "aws_kinesisvideo_stream_playback_endpoint" "example" {
  stream_name = aws_kinesisvideo_stream.example.name
}
    