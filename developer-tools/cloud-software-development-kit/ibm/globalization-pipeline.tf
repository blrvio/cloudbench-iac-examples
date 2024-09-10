
    # Configure the IBM Cloud Provider
provider "ibm" {
  region = "us-south"
  # Set your IBM Cloud API key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Globalization Pipeline
resource "ibm_globalization_pipeline" "main" {
  name     = "my-globalization-pipeline"
  location = "us-south"
  # Create a pipeline with default settings
  # Specify the resources, tools and settings used for the pipeline
}

# Create a Globalization Pipeline Job
resource "ibm_globalization_pipeline_job" "main" {
  globalization_pipeline_id = ibm_globalization_pipeline.main.id
  name     = "my-globalization-job"
  # Specify job settings, like input/output formats and languages
}

  