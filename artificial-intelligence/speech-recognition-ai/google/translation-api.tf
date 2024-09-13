
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
}

# Crie uma chave de API
resource "google_project_service" "translate_api" {
  service = "translate.googleapis.com"
  disable_on_destroy = false
}

# Crie uma chave de API para o serviço de tradução
resource "google_project_service" "translate_api_key" {
  service = "translate.googleapis.com"
  disable_on_destroy = false
}

# Traduza um texto
output "translation" {
  value = google_translate_text.translate.translated_text
}

resource "google_translate_text" "translate" {
  target_language = "es"
  text = "Hello World"
  project = "gcp-project-id"
}
    