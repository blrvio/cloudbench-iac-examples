
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um Data Hub
resource "aws_analytics_hub_data_hub" "example" {
  name = "example-data-hub"

  tags = {
    Name = "example-data-hub"
  }
}

# Crie um Data Source
resource "aws_analytics_hub_data_source" "example" {
  data_hub_id    = aws_analytics_hub_data_hub.example.id
  data_source_id = "example-data-source"
  data_source_type = "example-data-source-type"
  description    = "example-data-source-description"

  tags = {
    Name = "example-data-source"
  }
}

# Crie um Data Set
resource "aws_analytics_hub_data_set" "example" {
  data_hub_id   = aws_analytics_hub_data_hub.example.id
  data_set_id  = "example-data-set"
  description  = "example-data-set-description"
  data_source_id = aws_analytics_hub_data_source.example.id

  tags = {
    Name = "example-data-set"
  }
}
    