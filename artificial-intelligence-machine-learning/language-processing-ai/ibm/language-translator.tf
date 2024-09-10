
    # Configure the IBM Cloud Provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create a Language Translator Service
resource "ibm_language_translator_service" "main" {
  name        = "my-language-translator-service"
  plan        = "lite"
  instance_id = "YOUR_INSTANCE_ID"
}

# Create a Language Translator Model
resource "ibm_language_translator_model" "main" {
  name            = "my-language-translator-model"
  service_id      = ibm_language_translator_service.main.id
  base_model_id = "en-es"
  domain         = "general"
}

# Translate a text
output "translation" {
  value = ibm_language_translator_translate.main.translation
}

resource "ibm_language_translator_translate" "main" {
  service_id      = ibm_language_translator_service.main.id
  model_id        = ibm_language_translator_model.main.id
  text            = "Hello world!"
  target_language = "es"
}
  