
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Text-to-Speech voice
resource "google_text_to_speech_voice" "default" {
  name        = "my-voice"
  language_code = "en-US"
  name_suffix  = "default"
  ssml_gender  = "FEMALE"
}

# Create a Text-to-Speech synthesis input
resource "google_text_to_speech_synthesis_input" "default" {
  text = "Hello, world!"
  voice {
    name = google_text_to_speech_voice.default.name
  }
  audio_config {
    audio_encoding = "MP3"
  }
}

# Create a Text-to-Speech synthesis config
resource "google_text_to_speech_synthesis_config" "default" {
  input  = google_text_to_speech_synthesis_input.default.id
  name = "my-synthesis-config"
}

# Create a Text-to-Speech synthesis output
resource "google_text_to_speech_synthesis_output" "default" {
  synthesis_config = google_text_to_speech_synthesis_config.default.id
  name = "my-synthesis-output"
}

# Create a Text-to-Speech synthesis job
resource "google_text_to_speech_synthesis_job" "default" {
  name              = "my-synthesis-job"
  synthesis_config = google_text_to_speech_synthesis_config.default.id
  output_uri        = "gs://my-bucket/my-output.mp3"
}

  