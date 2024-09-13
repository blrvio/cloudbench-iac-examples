
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um detector de fraude
resource "aws_frauddetector_detector" "my_detector" {
  name        = "my_detector"
  description = "My fraud detector"
  event_type  = "my_event_type"
  model_id    = "my_model"
  rules        = ["my_rule1", "my_rule2"] # Substitua pelos IDs das regras
}

# Crie um modelo de fraude
resource "aws_frauddetector_model" "my_model" {
  name                 = "my_model"
  description         = "My fraud model"
  event_type         = "my_event_type"
  training_data_source = "my_training_data"
  model_type           = "fraud_detection"
}

# Crie uma regra de fraude
resource "aws_frauddetector_rule" "my_rule" {
  name           = "my_rule"
  description    = "My fraud rule"
  detector_id    = aws_frauddetector_detector.my_detector.id
  expression     = "event.value >= 10"
  outcomes       = ["FRAUD"]
  rule_version    = 1
  rule_execution_mode = "FIRST_MATCHED"
}

# Crie um conjunto de dados de treinamento
resource "aws_frauddetector_training_data_source" "my_training_data" {
  name           = "my_training_data"
  event_type     = "my_event_type"
  training_data  = "s3://my-bucket/my-training-data.csv" # Substitua pelo caminho do arquivo de treinamento
  event_timestamp_field = "timestamp"
  label_field          = "fraud"
}

# Crie um tipo de evento
resource "aws_frauddetector_event_type" "my_event_type" {
  name        = "my_event_type"
  description = "My event type"
  entity_types = ["CUSTOMER"]
  event_variables = [
    {
      name  = "value"
      data_type = "STRING"
    }
  ]
}

    