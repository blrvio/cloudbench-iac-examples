
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um classificador de linguagem natural
resource "aws_natural_language_understanding_classifier" "my_classifier" {
  name = "my-classifier"
  version_name = "my-classifier-v1"
  language_code = "en"
  classifier_metadata {
    description = "This is a classifier for my data"
  }
  training_data_uri = "s3://my-bucket/my-classifier-training-data.json"
  # Define a lista de classes e as entidades correspondentes
  classes = [{"name": "Class 1", "entities": [{"entity": "Entity 1"}, {"entity": "Entity 2"}]}, {"name": "Class 2", "entities": [{"entity": "Entity 3"}, {"entity": "Entity 4"}]}]
}

    