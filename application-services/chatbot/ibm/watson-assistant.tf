
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create a Watson Assistant service
resource "ibm_watson_assistant_service" "main" {
  name     = "my-watson-assistant"
  plan     = "lite"
  location = "us-south"
}

# Create a Watson Assistant workspace
resource "ibm_watson_assistant_workspace" "main" {
  assistant_id = ibm_watson_assistant_service.main.id
  name        = "my-watson-workspace"
}

# Create an intent for the Watson Assistant workspace
resource "ibm_watson_assistant_intent" "main" {
  workspace_id = ibm_watson_assistant_workspace.main.id
  name         = "greeting"
  description  = "A greeting intent"
  examples     = ["Hello", "Hi", "Good morning"]
}

# Create an entity for the Watson Assistant workspace
resource "ibm_watson_assistant_entity" "main" {
  workspace_id = ibm_watson_assistant_workspace.main.id
  name         = "location"
  description  = "A location entity"
  values       = ["New York", "London", "Tokyo"]
}

# Create a dialog node for the Watson Assistant workspace
resource "ibm_watson_assistant_dialog_node" "main" {
  workspace_id = ibm_watson_assistant_workspace.main.id
  name         = "greeting_node"
  conditions   = ["#greeting"]
  output        = {
    text = "Hello there! How can I help you today?"
  }
}

# Create a skill for the Watson Assistant workspace
resource "ibm_watson_assistant_skill" "main" {
  workspace_id = ibm_watson_assistant_workspace.main.id
  name         = "my-skill"
  description  = "A sample skill"
}

# Create a webhook for the Watson Assistant workspace
resource "ibm_watson_assistant_webhook" "main" {
  workspace_id = ibm_watson_assistant_workspace.main.id
  name         = "my-webhook"
  url          = "https://example.com/webhook"
}

  