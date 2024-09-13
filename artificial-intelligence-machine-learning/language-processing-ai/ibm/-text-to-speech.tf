
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
}

# Crie um arquivo de voz com o conteúdo do TTS
resource "google_speech_synthesis_voice" "sample_voice" {
  name        = "voice-name"
  input_text = "Exemplo de texto para ser convertido em fala"
  language_code = "pt-BR"
}

# Baixe o arquivo de voz
resource "google_storage_bucket_object" "download_audio" {
  name = "sample-audio"
  bucket = "bucket-name"
  source = google_speech_synthesis_voice.sample_voice.audio_content
}

# Baixe o arquivo de voz para o diretório local
resource "local_file" "sample_audio_local" {
  filename = "sample-audio.mp3"
  content  = google_storage_bucket_object.download_audio.content
}
    