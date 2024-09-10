
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Personalize dataset group
resource "aws_personalize_dataset_group" "main" {
  name = "my-personalize-dataset-group"
  # Configure the dataset group settings
  dataset_group_config {
    # Choose the type of recommendation model to create
    recipe_arn = "arn:aws:personalize:us-east-1:123456789012:recipe/personalize-knn-user-personalization"
  }
}

# Create a Personalize dataset
resource "aws_personalize_dataset" "interactions" {
  dataset_group_name = aws_personalize_dataset_group.main.name
  name                = "interactions"
  # Configure the dataset type
  dataset_type = "INTERACTIONS"
  # Import your dataset from an S3 bucket
  schema_arn = "arn:aws:personalize:us-east-1:123456789012:schema/my-schema"
  # Set the data source to an S3 bucket
  data_source {
    s3_data_source {
      bucket_name = "my-bucket"
      s3_data_path = "interactions.csv"
    }
  }
}

# Create a Personalize solution
resource "aws_personalize_solution" "main" {
  name                 = "my-personalize-solution"
  dataset_group_name   = aws_personalize_dataset_group.main.name
  solution_config {
    # Choose the training algorithm to use
    recipe_arn = "arn:aws:personalize:us-east-1:123456789012:recipe/personalize-knn-user-personalization"
  }
}

# Create a Personalize campaign
resource "aws_personalize_campaign" "main" {
  name                 = "my-personalize-campaign"
  solution_arn          = aws_personalize_solution.main.arn
  campaign_config {
    # Configure the campaign settings
    min_recommendation_confidence = 0.0
  }
}

# Create a Personalize schema
resource "aws_personalize_schema" "main" {
  name         = "my-schema"
  # Define the schema for your dataset
  schema {
    user_id_field = "user_id"
    item_id_field = "item_id"
    event_type_field = "event_type"
    timestamp_field = "timestamp"
  }
}

  