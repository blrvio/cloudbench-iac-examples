
    # Configure the IBM Cloud provider
provider "ibm" {
  ibmcloud_api_key = "YOUR_IBM_CLOUD_API_KEY"  # Replace with your IBM Cloud API key
  region = "us-south" # Replace with your desired region
}

# Create a Watson Machine Learning service instance
resource "ibm_ml_service" "main" {
  name = "my-ml-service" # Replace with your desired service instance name
  plan = "lite" # Replace with your desired plan
}

# Create a Watson Machine Learning model
resource "ibm_ml_model" "main" {
  name          = "my-ml-model" # Replace with your desired model name
  service_id     = ibm_ml_service.main.id # Service instance ID
  model_type   = "python" # Model type (e.g., python, spss, etc.)
  training_data = "s3://my-bucket/my-data.csv" # Path to training data
  deployment_target = "default" # Deployment target (e.g., default, cloud, etc.)
  # Optional settings for model training
  training_params = {
    algorithm = "linear_regression"
    # Add other algorithm specific parameters as needed
  }
}

# Deploy the model
resource "ibm_ml_deployment" "main" {
  model_id    = ibm_ml_model.main.id # Model ID
  service_id     = ibm_ml_service.main.id # Service instance ID
  name        = "my-deployment" # Deployment name
  deployment_target = "default" # Deployment target (e.g., default, cloud, etc.)
  # Optional settings for deployment
  deployment_params = {
    # Add other deployment parameters as needed
  }
}
  