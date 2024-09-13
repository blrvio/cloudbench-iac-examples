
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Crie um arquivo de voz
resource "google_text_to_speech_voice" "my_voice" {
  name     = "my-voice"
  language_code = "en-US"
  ssml_gender = "MALE"
}

# Crie um arquivo de texto para sintetizar
resource "google_storage_bucket" "my_bucket" {
  name    = "my-bucket"
  location = "US"
}

resource "google_storage_bucket_object" "my_text" {
  name    = "my-text.txt"
  bucket  = google_storage_bucket.my_bucket.name
  source  = "your-text-file.txt"
}

# Sintetize a voz
resource "google_text_to_speech_synthesis" "my_synthesis" {
  input {
    text = file(google_storage_bucket_object.my_text.self_link)
  }
  voice {
    name = google_text_to_speech_voice.my_voice.name
  }
  audio_config {
    audio_encoding = "LINEAR16"
  }
  output_config {
    gcs_uri = "gs://my-bucket/my-speech.mp3"
  }
}
    