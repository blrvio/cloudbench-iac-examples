
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um stream de vídeo Kinesis
resource "aws_kinesis_video_stream" "example" {
  data_retention_in_hours = 12
  name                      = "my-video-stream"
  tags = {
    Name = "My Video Stream"
  }
}

# Crie um endpoint de gravação para o stream de vídeo
resource "aws_kinesis_video_stream_recording" "example" {
  kinesis_video_stream_name = aws_kinesis_video_stream.example.name
  name                      = "my-recording"
}

# Crie uma chave de acesso para o stream de vídeo
resource "aws_kinesis_video_stream_access_key" "example" {
  kinesis_video_stream_name = aws_kinesis_video_stream.example.name
  name                      = "my-access-key"
  single_master_access    = true
}
    