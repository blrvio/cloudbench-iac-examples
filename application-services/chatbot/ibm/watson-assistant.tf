
      # Configure o provedor do IBM Cloud
provider "ibm" {
  api_key     = "your_api_key" # Substitua pela sua API key
  region       = "us-south" # Substitua pela região desejada
  service_name = "watson-assistant" # Nome do serviço Watson Assistant
}

# Crie um assistente
resource "ibm_watson_assistant_assistant" "my_assistant" {
  name = "My Assistant"
  description = "My first assistant"
  language = "en"
}

# Crie um intent
resource "ibm_watson_assistant_intent" "my_intent" {
  assistant_id = ibm_watson_assistant_assistant.my_assistant.id
  name         = "Welcome Intent"
  description  = "Welcome the user"
  examples      = ["Hello", "Hi", "Good morning"]
}

# Crie uma entidade
resource "ibm_watson_assistant_entity" "my_entity" {
  assistant_id = ibm_watson_assistant_assistant.my_assistant.id
  name         = "Location"
  description  = "Location of the user"
  values        = ["New York", "London", "Tokyo"]
}

# Crie uma ação de diálogo
resource "ibm_watson_assistant_dialog_node" "my_dialog_node" {
  assistant_id = ibm_watson_assistant_assistant.my_assistant.id
  name         = "Welcome Node"
  description  = "Welcome the user and ask for their location"
  conditions    = "$welcome_intent"
  output        = {
    text = "Hello! What is your location?"
  }
}

# Crie um exemplo de treinamento
resource "ibm_watson_assistant_training_example" "my_training_example" {
  assistant_id = ibm_watson_assistant_assistant.my_assistant.id
  intent_id   = ibm_watson_assistant_intent.my_intent.id
  text        = "Hello, I'm in New York"
  entities     = [{"entity": "Location", "value": "New York"}]
}
    