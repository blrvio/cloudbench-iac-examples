
    # Configure the Google Cloud provider
provider "google" {
  project  = "your-gcp-project-id"
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Create a Dialogflow agent
resource "google_dialogflow_cx_agent" "main" {
  display_name = "my-agent"
  default_language_code = "en"
  location = google_dialogflow_cx_agent.main.location
}

# Create a Dialogflow intent
resource "google_dialogflow_cx_intent" "main" {
  display_name        = "my-intent"
  training_phrases { training_phrase_parts { text = "Hello" } }
  parent               = google_dialogflow_cx_agent.main.name
  location             = google_dialogflow_cx_agent.main.location
  is_fallback          = false
}

# Create a Dialogflow flow
resource "google_dialogflow_cx_flow" "main" {
  display_name = "my-flow"
  parent        = google_dialogflow_cx_agent.main.name
  location      = google_dialogflow_cx_agent.main.location
  event_handlers { event = "WELCOME" } 
}

# Create a Dialogflow page
resource "google_dialogflow_cx_page" "main" {
  display_name = "my-page"
  parent        = google_dialogflow_cx_flow.main.name
  location      = google_dialogflow_cx_agent.main.location
  transition_routes { trigger_fulfillment { webhook { uri = "https://example.com/webhook" } } }
}

# Create a Dialogflow webhook
resource "google_dialogflow_cx_webhook" "main" {
  display_name = "my-webhook"
  parent        = google_dialogflow_cx_agent.main.name
  location      = google_dialogflow_cx_agent.main.location
  generic_web_service {
    uri = "https://example.com/webhook"
  }
  timeout_millis = 5000
}

  