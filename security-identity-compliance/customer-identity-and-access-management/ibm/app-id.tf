
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  # API key for authentication
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create an App ID service instance
resource "ibm_appid" "main" {
  name = "my-app-id-instance"
  # You can choose a plan based on your requirements
  plan = "lite"
  # The location where your App ID service will be created.
  location = "us-south"
}

# Create an App ID Authentication service instance
resource "ibm_appid_authentication" "main" {
  app_id_service_instance_id = ibm_appid.main.id
  # You can customize the name of your service instance
  name = "my-authentication-service"
  # Choose a service plan
  plan = "free"
  # The location where your Authentication service will be created.
  location = "us-south"
}

  