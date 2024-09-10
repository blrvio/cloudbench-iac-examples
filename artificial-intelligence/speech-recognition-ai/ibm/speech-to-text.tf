
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Speech to Text resource
resource "ibm_speech_to_text" "main" {
  name = "my-speech-to-text-resource"
  # Optional configuration options:
  # model = "en-US_BroadbandModel"
}

# Create a Speech to Text Language Model
resource "ibm_speech_to_text_language_model" "main" {
  name = "my-custom-language-model"
  # Optional configuration options:
  # base_model_name = "en-US_BroadbandModel"
}

# Create a Speech to Text Custom Acoustic Model
resource "ibm_speech_to_text_acoustic_model" "main" {
  name = "my-custom-acoustic-model"
  # Optional configuration options:
  # base_model_name = "en-US_BroadbandModel"
}

  