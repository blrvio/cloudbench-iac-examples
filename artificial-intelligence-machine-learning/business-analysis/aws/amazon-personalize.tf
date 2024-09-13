
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um dataset de eventos
resource "aws_personalize_dataset" "events" {
  name   = "events"
  dataset_type = "EVENT"
  schema_arn  = "arn:aws:personalize:us-east-1:123456789012:schema:schema-123456789012"
}

# Crie um dataset de usuários
resource "aws_personalize_dataset" "users" {
  name   = "users"
  dataset_type = "USER"
  schema_arn  = "arn:aws:personalize:us-east-1:123456789012:schema:schema-123456789012"
}

# Crie um dataset de itens
resource "aws_personalize_dataset" "items" {
  name   = "items"
  dataset_type = "ITEM"
  schema_arn  = "arn:aws:personalize:us-east-1:123456789012:schema:schema-123456789012"
}

# Crie um esquema para o dataset
resource "aws_personalize_schema" "schema" {
  name     = "schema"
  schema   = "{\"type\": \"record\", \"name\": \"schema\", \"namespace\": \"com.example\", \"fields\": [{\"name\": \"user_id\", \"type\": \"string\"}, {\"name\": \"item_id\", \"type\": \"string\"}, {\"name\": \"event_type\", \"type\": \"string\"}]}"
}

# Crie um modelo de recomendação
resource "aws_personalize_solution" "recommendation_model" {
  name  = "recommendation_model"
  recipe_arn = "arn:aws:personalize:us-east-1:123456789012:recipe/PERSONALIZE-DEFAULT-USER-PERSONALIZATION"
  training_data_config {
    dataset_group_arn = "arn:aws:personalize:us-east-1:123456789012:dataset-group:dataset-group-123456789012"
  }
}

# Crie um grupo de datasets para o modelo
resource "aws_personalize_dataset_group" "dataset_group" {
  name = "dataset-group"
}

# Crie um esquema para o dataset
resource "aws_personalize_schema" "schema" {
  name     = "schema"
  schema   = "{\"type\": \"record\", \"name\": \"schema\", \"namespace\": \"com.example\", \"fields\": [{\"name\": \"user_id\", \"type\": \"string\"}, {\"name\": \"item_id\", \"type\": \"string\"}, {\"name\": \"event_type\", \"type\": \"string\"}]}"
}
    