
    # Configure the Oracle Cloud provider
provider "oci" {
  # Configure the provider with your Oracle Cloud credentials
  # Replace with your tenancy OCID, user OCID, and private key
  tenancy_ocid  = "ocid1.tenancy.oc1..aaaaaaaaz424535z3n325m3x6y4744624k7w4"
  user_ocid     = "ocid1.user.oc1..aaaaaaaaz424535z3n325m3x6y4744624k7w4"
  private_key   = "your_private_key"
  region        = "us-ashburn-1"
}

# Create an Oracle Digital Assistant
resource "oci_digital_assistant_assistant" "main" {
  # Replace with a unique name for your digital assistant
  display_name = "My Digital Assistant"
  # Set the language for your digital assistant
  language = "en-US"
  # Set the description for your digital assistant
  description  = "A simple chatbot built with Oracle Digital Assistant"
  # Create a unique ID for your digital assistant
  id           = "ocid1.digitalassistant.oc1..aaaaaaaaz424535z3n325m3x6y4744624k7w4"
}

# Create an intent for your digital assistant
resource "oci_digital_assistant_intent" "main" {
  assistant_id = oci_digital_assistant_assistant.main.id
  display_name = "Greeting"
  # Define the intent's training phrases
  training_phrases = [
    "hello",
    "hi",
    "good morning",
    "good afternoon"
  ]
}

# Create an action for your digital assistant
resource "oci_digital_assistant_action" "main" {
  assistant_id = oci_digital_assistant_assistant.main.id
  display_name = "Greeting Response"
  # Define the action's response
  response = "Hello there! How can I help you today?"
  # Define the intent associated with this action
  intent_id = oci_digital_assistant_intent.main.id
}

  