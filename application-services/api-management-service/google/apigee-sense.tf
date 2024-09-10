
    ## Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Replace with your desired region
}

## Create an Apigee Sense Instance
resource "google_apigee_instance" "main" {
  name = "your-apigee-sense-instance"
  location  = "us-central1" # Replace with your desired region
  environment = "sense"
  # Define desired resource settings
  # Refer to documentation for available options:
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/apigee_instance
}

## Create an Apigee Sense Environment
resource "google_apigee_environment" "main" {
  instance = google_apigee_instance.main.name
  name     = "your-apigee-sense-environment"
  location  = "us-central1" # Replace with your desired region
  # Define desired resource settings
  # Refer to documentation for available options:
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/apigee_environment
}
  