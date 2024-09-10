
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  # Set your IBM Cloud API Key as an environment variable
  api_key = var.ibm_api_key
}

# Create a Text to Speech service instance
resource "ibm_tts_instance" "default" {
  name = "my-text-to-speech-instance"
  # Choose a suitable plan
  plan = "lite"
}

# Create a Text to Speech voice
resource "ibm_tts_voice" "default" {
  instance_id = ibm_tts_instance.default.id
  name = "my-custom-voice"
  language = "en-US"
  gender = "male"
  # Provide a custom voice model
  custom_voice_model = "path/to/your/voice/model.zip"
}

# Create a Text to Speech custom pronunciation
resource "ibm_tts_pronunciation" "default" {
  instance_id = ibm_tts_instance.default.id
  name = "my-custom-pronunciation"
  # Define custom pronunciations for specific words
  pronunciation = [
    {
      word = "example"
      phonetic = "EK-ZAM-PUL"
    }
  ]
}

# Create a Text to Speech translation
resource "ibm_tts_translation" "default" {
  instance_id = ibm_tts_instance.default.id
  name = "my-custom-translation"
  # Define custom translations for specific words
  translation = [
    {
      source_language = "en-US"
      target_language = "es-ES"
      word = "hello"
      translation = "hola"
    }
  ]
}
  