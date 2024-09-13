
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Crie um arquivo de áudio a partir de texto
resource "google_text_to_speech_voice" "default" {
  name     = "my-voice"
  language_code = "en-US"
  name     = "en-US-Standard-A"
}

resource "google_text_to_speech_synthesis_input" "default" {
  text = "Hello, world!"
}

resource "google_text_to_speech_synthesis" "default" {
  input = google_text_to_speech_synthesis_input.default.id
  voice = google_text_to_speech_voice.default.id
  audio_config {
    audio_encoding = "LINEAR16"
  }
  name = "my-audio"
}

    