
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Fraud Detector Detector
resource "aws_frauddetector_detector" "main" {
  name = "my-fraud-detector"
  # Optional settings
  description = "My fraud detector"
  event_type = "my-event-type"
  # Configure the model versions used by the detector
  model_versions = [
    "my-model-version"
  ]
  # Configure the rules used by the detector
  rules = [
    {
      name = "my-rule"
      # Define the rule expression
      expression = "(accountAge < 30) AND (ipReputation = "LOW")"
      # Define the rule action
      action = "FLAG"
      # Set the rule priority
      priority = 1
    }
  ]
}

# Create a Fraud Detector Event Type
resource "aws_frauddetector_event_type" "main" {
  name = "my-event-type"
  # Optional settings
  description = "My event type"
  # Define the event type entities
  entities = [
    {
      name = "account"
      # Define the entity type
      entity_type = "ACCOUNT"
    },
    {
      name = "ip"
      # Define the entity type
      entity_type = "IP"
    }
  ]
  # Define the event type variables
  variables = [
    {
      name = "accountAge"
      # Define the variable type
      variable_type = "INTEGER"
      # Define the variable data type
      data_type = "INTEGER"
    },
    {
      name = "ipReputation"
      # Define the variable type
      variable_type = "STRING"
      # Define the variable data type
      data_type = "STRING"
    }
  ]
}

# Create a Fraud Detector Model
resource "aws_frauddetector_model" "main" {
  name = "my-model"
  # Define the model type
  model_type = "ONLINE_FRAUD_INFERENCE"
  # Optional settings
  description = "My model"
  event_type = aws_frauddetector_event_type.main.name
  # Define the model training configuration
  training_config {
    # Configure the training mode
    training_mode = "AUTO_RETRAIN"
  }
}

# Create a Fraud Detector Model Version
resource "aws_frauddetector_model_version" "main" {
  model_id = aws_frauddetector_model.main.id
  # Define the model version name
  name = "my-model-version"
  # Optional settings
  description = "My model version"
  # Define the model version training configuration
  training_config {
    # Configure the training mode
    training_mode = "AUTO_RETRAIN"
  }
}

# Create a Fraud Detector Label
resource "aws_frauddetector_label" "main" {
  name = "my-label"
  # Optional settings
  description = "My label"
  # Define the label type
  label_type = "FRAUD"
  # Define the label description
  label_description = "Fraudulent activity"
}

  