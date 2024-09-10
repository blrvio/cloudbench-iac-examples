
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create an IBM Cloud Functions action
resource "ibm_functions_action" "main" {
  name     = "my-function"
  runtime  = "nodejs:16"
  code     = "// Your function code here"
  memory   = 128
  timeout  = 60
  trigger  = "http"
  location = "us-south"
}

# Create an IBM Cloud Functions package
resource "ibm_functions_package" "main" {
  name     = "my-package"
  location = "us-south"
  actions  = [ibm_functions_action.main.name]
}

  