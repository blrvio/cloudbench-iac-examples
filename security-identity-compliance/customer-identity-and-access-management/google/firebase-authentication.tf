
      # Configure o provedor do Firebase
provider "firebase" {
  project = "my-firebase-project"
}

# Crie um provedor de autenticação de email/senha
resource "firebase_auth_provider" "email_password" {
  project = firebase.project
  provider = "email"
}

# Crie um provedor de autenticação do Google
resource "firebase_auth_provider" "google" {
  project = firebase.project
  provider = "google.com"
  enabled = true
}

# Crie um provedor de autenticação do Facebook
resource "firebase_auth_provider" "facebook" {
  project = firebase.project
  provider = "facebook.com"
  enabled = true
  client_id = "YOUR_FACEBOOK_APP_ID"
  client_secret = "YOUR_FACEBOOK_APP_SECRET"
}
    