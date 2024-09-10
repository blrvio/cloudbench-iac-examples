
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region     = "us-south"
  api_key    = "your_api_key"
  account_id = "your_account_id"
}

# Create a Code Engine namespace
resource "ibm_codeengine_namespace" "main" {
  name    = "my-namespace"
  location = "us-south"
}

# Create a Code Engine application
resource "ibm_codeengine_application" "main" {
  name       = "my-application"
  namespace  = ibm_codeengine_namespace.main.name
  runtime    = "nodejs-16"
  location   = "us-south"
  build_image = "us.icr.io/ibm-codeengine/nodejs:16-ubi8"
}

# Create a Code Engine service
resource "ibm_codeengine_service" "main" {
  name       = "my-service"
  application = ibm_codeengine_application.main.name
  namespace  = ibm_codeengine_namespace.main.name
  location   = "us-south"
  route      = "my-service.my-namespace.us-south.codeengine.appdomain.cloud"
}

  