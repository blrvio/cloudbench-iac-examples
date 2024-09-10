
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key  = "YOUR_IBM_API_KEY"
  region   = "us-south"
  account_id = "YOUR_IBM_ACCOUNT_ID"
}

# Create a DataStage job
resource "ibm_datastage_job" "main" {
  name        = "my-datastage-job"
  project     = "my-project"
  description = "My first DataStage job"
  # Define the job's properties
  properties = {
    "jobType" = "Sequential"
  }
  # Define the job's steps
  steps = [
    {
      "name" = "Load data"
      "type" = "Stage"
      "properties" = {
        "inputSource" = "my-input-dataset"
        "outputTarget" = "my-output-dataset"
      }
    }
  ]
}

# Create a DataStage project
resource "ibm_datastage_project" "main" {
  name        = "my-project"
  description = "My first DataStage project"
}

# Create a DataStage dataset
resource "ibm_datastage_dataset" "main" {
  name        = "my-input-dataset"
  project     = "my-project"
  description = "My input dataset"
  # Define the dataset's properties
  properties = {
    "type" = "Table"
  }
}

# Create another DataStage dataset
resource "ibm_datastage_dataset" "output_dataset" {
  name        = "my-output-dataset"
  project     = "my-project"
  description = "My output dataset"
  # Define the dataset's properties
  properties = {
    "type" = "Table"
  }
}

  