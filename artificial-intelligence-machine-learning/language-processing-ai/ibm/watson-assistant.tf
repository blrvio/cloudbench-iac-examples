
    # Configure the IBM Cloud Provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY" # Replace with your actual IBM Cloud API Key
  region = "us-south" # Replace with the region where your Watson Assistant is located
}

# Create a Watson Assistant Service
resource "ibm_watson_assistant_service" "main" {
  name   = "my-watson-assistant"
  plan   = "lite"
  version = "2021-06-14"
  # Optional: Define the service instance's location
  location = "us-south"
}

# Create a Watson Assistant Workspace
resource "ibm_watson_assistant_workspace" "main" {
  service_instance_id = ibm_watson_assistant_service.main.id
  name  = "my-watson-assistant-workspace"
  # Define the language of the workspace
  language = "en"
  # Optional: Set the description of the workspace
  description = "This is my Watson Assistant workspace"
}

# Create a Watson Assistant Intent
resource "ibm_watson_assistant_intent" "main" {
  workspace_id = ibm_watson_assistant_workspace.main.id
  name  = "Greeting"
  # Define the example user utterances for this intent
  examples = ["Hello", "Hi", "Good morning"]
}

# Create a Watson Assistant Entity
resource "ibm_watson_assistant_entity" "main" {
  workspace_id = ibm_watson_assistant_workspace.main.id
  name  = "City"
  # Define the values that this entity can take
  values = ["New York", "London", "Paris"]
}

# Create a Watson Assistant Dialog Node
resource "ibm_watson_assistant_dialog_node" "main" {
  workspace_id = ibm_watson_assistant_workspace.main.id
  name  = "Welcome Node"
  # Define the conditions for this node to be triggered
  conditions = "#Greeting"
  # Define the text that should be displayed to the user
  output = "Welcome to my Watson Assistant! What city are you interested in?"
  # Define the next node to transition to
  next_step = "#City Node"
}

# Create another Dialog Node to handle the City Entity
resource "ibm_watson_assistant_dialog_node" "city" {
  workspace_id = ibm_watson_assistant_workspace.main.id
  name  = "City Node"
  # Define the conditions for this node to be triggered
  conditions = "$City"
  # Define the text that should be displayed to the user
  output = "You are interested in {{ $City }}, interesting! Anything else?"
}

  