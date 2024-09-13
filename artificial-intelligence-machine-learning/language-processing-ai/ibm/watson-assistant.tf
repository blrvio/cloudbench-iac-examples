
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "YOUR_API_KEY"
  region  = "us-south"
}

# Crie um assistente Watson
resource "ibm_watson_assistant_assistant" "my_assistant" {
  name     = "My Assistant"
  description = "My first Watson Assistant"
  language = "en"
}

# Crie um intent
resource "ibm_watson_assistant_intent" "greeting_intent" {
  assistant_id = ibm_watson_assistant_assistant.my_assistant.id
  name = "Greeting"
  description = "Intent para saudações"
  user_says = [
    "Hello",
    "Hi",
    "Good morning"
  ]
}

# Crie uma entidade
resource "ibm_watson_assistant_entity" "city_entity" {
  assistant_id = ibm_watson_assistant_assistant.my_assistant.id
  name = "City"
  description = "Entidade para cidades"
  values = [
    {"value": "New York", "synonyms": ["NYC"]},
    {"value": "London", "synonyms": ["Big Ben"]}
  ]
}

# Crie uma resposta de diálogo
resource "ibm_watson_assistant_dialog_node" "greeting_response" {
  assistant_id = ibm_watson_assistant_assistant.my_assistant.id
  dialog_node = "welcome"
  conditions = "#greeting_intent"
  output {
    text {
      values = ["Hello! How can I help you today?"]
    }
  }
}
    