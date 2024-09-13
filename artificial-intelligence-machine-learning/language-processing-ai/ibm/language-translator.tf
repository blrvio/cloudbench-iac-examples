
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Crie um modelo de tradução
resource "google_translate_model" "default" {
  name = "my-translation-model"
  source_language_code = "en"
  target_language_code = "fr"
}

# Crie um recurso de tradução
resource "google_translate_translation" "default" {
  model  = google_translate_model.default.name
  contents = "Hello world"
  source_language_code = "en"
  target_language_code = "fr"
}
    