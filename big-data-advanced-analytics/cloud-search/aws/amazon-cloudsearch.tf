
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a CloudSearch Domain
resource "aws_cloudsearch_domain" "main" {
  name = "my-cloudsearch-domain" # Name of your CloudSearch domain
  # Optional configuration settings
  domain_endpoint_options {
    # Set the desired endpoint for your domain
    enforced_https = true
  }
  # Define the access policies for your domain
  access_policies {
    # Set the desired access policies
    # Example:
    # access_policy { 
    #   allow_all_domains = true
    # }
  }
  # Define the indexing options for your domain
  indexing_options {
    # Set the desired indexing options
    # Example:
    # indexing_schedule = "hourly"
  }
  # Define the search experience configuration for your domain
  search_experience_options {
    # Set the desired search experience configuration
    # Example:
    # suggest {
    #   enabled = true
    # }
  }
  # Define the capacity configuration for your domain
  capacity {
    # Set the desired capacity configuration
    # Example:
    # search_instance_type = "search.m3.medium"
  }
}

# Create a CloudSearch Domain Index Field
resource "aws_cloudsearch_domain_index_field" "main" {
  domain_id = aws_cloudsearch_domain.main.id # ID of your CloudSearch domain
  name      = "my-index-field" # Name of your index field
  # Define the type of your index field
  type = "text"
  # Optional configuration settings
  # index_options {
  #   index_field_options { 
  #     # Example configuration settings for index field options
  #     highlight = true
  #   }
  # }
  # faceted = false
}

# Create a CloudSearch Domain Index Field Option
resource "aws_cloudsearch_domain_index_field_option" "main" {
  domain_id = aws_cloudsearch_domain.main.id # ID of your CloudSearch domain
  # Option to set for the index field
  option_name = "IndexFieldOptions"
  # The name of the index field to apply the option to
  index_field_name = "my-index-field"
  # Configuration settings for the index field option
  index_field_options { 
    # Example configuration settings for index field options
    highlight = true
  }
}

# Create a CloudSearch Domain User
resource "aws_cloudsearch_domain_user" "main" {
  domain_id = aws_cloudsearch_domain.main.id # ID of your CloudSearch domain
  user_name = "my-user" # Name of your CloudSearch user
  # Optional configuration settings
  # access_policies { 
  #   # Example access policies settings
  #   allow_all_domains = true
  # }
}

# Create a CloudSearch Domain Service Access Policy
resource "aws_cloudsearch_domain_service_access_policy" "main" {
  domain_id = aws_cloudsearch_domain.main.id # ID of your CloudSearch domain
  # The access policy to apply to the domain
  access_policy = jsonencode( { 
    # Example access policy settings
    # allow_all_domains = true
  })
}

# Create a CloudSearch Domain Document
resource "aws_cloudsearch_domain_document" "main" {
  domain_id = aws_cloudsearch_domain.main.id # ID of your CloudSearch domain
  # The document content to add to the domain
  document = jsonencode({
    # Example document content
    # "id": "123",
    # "title": "My Document"
  })
}

  