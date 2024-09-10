
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Change to your desired region
}

# Create a Dialogflow Agent
resource "google_dialogflow_agent" "main" {
  display_name = "my-dialogflow-agent"
  default_language_code = "en-US"
  # Optional parameters
  # time_zone = "America/New_York"
  # default_flow_id = "projects/your-gcp-project-id/locations/us-central1/agents/your-dialogflow-agent/flows/your-default-flow"
  # parent = "projects/your-gcp-project-id"
}

# Create an Intent
resource "google_dialogflow_intent" "main" {
  display_name = "greeting"
  agent       = google_dialogflow_agent.main.name
  # Optional parameters
  # priority = 1
  # is_fallback = false
  # live_agent_handoff = false
  # parent = google_dialogflow_agent.main.name
  # training_phrases = [{
  #   type = "EXAMPLE"
  #   parts = [{
  #     text = "Hello"
  #   }]
  # }, {
  #   type = "EXAMPLE"
  #   parts = [{
  #     text = "Hi"
  #   }]
  # }]
  # action = "input.welcome"
  # input_context_names = ["projects/your-gcp-project-id/locations/us-central1/agents/your-dialogflow-agent/contexts/your-context-name"]
  # output_contexts = ["projects/your-gcp-project-id/locations/us-central1/agents/your-dialogflow-agent/contexts/your-context-name"]
  # reset_contexts = true
  # events = ["projects/your-gcp-project-id/locations/us-central1/agents/your-dialogflow-agent/events/your-event-name"]
  # webhook_state = "ENABLED"
  # webhook_proxy_action = "projects/your-gcp-project-id/locations/us-central1/agents/your-dialogflow-agent/flows/your-flow-name/pages/your-page-name"
  # messages = [{
  #   text {
  #     text = "Hello there! How can I help you today?"
  #   }
  # }]
}

# Create an Entity
resource "google_dialogflow_entity" "main" {
  display_name = "pizza_size"
  agent       = google_dialogflow_agent.main.name
  # Optional parameters
  # kind = "KIND_MAP"
  # enable_fuzzy_extraction = false
  # auto_expansion_mode = "AUTO_EXPANSION_MODE_DEFAULT"
  # entries = [{
  #   value = "small"
  #   synonyms = ["S", "Small", "small"]
  # }]
  # parent = google_dialogflow_agent.main.name
  # is_system_entity = false
}

  