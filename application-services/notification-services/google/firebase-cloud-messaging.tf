
      # Configure o provedor do Firebase
provider "google" {
  project = "my-project-id" # Substitua pelo ID do seu projeto
}

# Crie um tópico do FCM
resource "google_firebase_messaging_topic" "my_topic" {
  name    = "my-topic"
  project = google_project.my-project.project_id
}

# Crie um serviço do FCM
resource "google_firebase_messaging_service" "my_service" {
  project = google_project.my-project.project_id
}

# Adicione uma chave API ao serviço do FCM
resource "google_firebase_messaging_api_key" "my_api_key" {
  service_id = google_firebase_messaging_service.my_service.service_id
  project = google_project.my-project.project_id
}

# Envie uma mensagem para um tópico
resource "google_firebase_messaging_message" "my_message" {
  project = google_project.my-project.project_id
  topic = google_firebase_messaging_topic.my_topic.name
  message {
    notification {
      title = "Título da Mensagem"
      body  = "Corpo da Mensagem"
    }
    android {
      notification {
        title = "Título da Mensagem"
        body  = "Corpo da Mensagem"
      }
    }
  }
}

# Crie uma chave API para o Firebase Admin SDK
resource "google_firebase_messaging_api_key" "admin_sdk_key" {
  service_id = google_firebase_messaging_service.my_service.service_id
  project = google_project.my-project.project_id
  type = "server"
}
    