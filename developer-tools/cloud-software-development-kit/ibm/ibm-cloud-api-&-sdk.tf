
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "your_api_key"
}

# Crie uma função do Cloud Functions
resource "ibm_cloud_functions_action" "my_function" {
  name     = "my_function"
  runtime  = "nodejs-16"
  code     = "// Your function code"
  region   = "us-south"
  trigger  = "http"
  memory   = 128
  timeout  = 60
}

# Crie um recurso do Cloud Object Storage
resource "ibm_cos_bucket" "my_bucket" {
  name   = "my_bucket"
  region = "us-south"
}
    