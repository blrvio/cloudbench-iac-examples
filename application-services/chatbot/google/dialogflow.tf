
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Crie um agente Dialogflow
resource "google_dialogflow_agent" "default" {
  display_name = "my-agent"
  default_language_code = "en"
}

# Crie um intent
resource "google_dialogflow_intent" "default" {
  display_name = "Welcome Intent"
  agent = google_dialogflow_agent.default.name
  training_phrases {
    type = "EXAMPLE"
    parts {
      text = "Hello"
    }
  }
  action = "input.welcome"
  output_contexts {
    name = "projects/your-project-id/agent/sessions/your-session-id/contexts/welcome"
  }
}
    