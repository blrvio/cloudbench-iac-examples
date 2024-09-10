
    # Configure the IBM Cloud Provider
provider "ibm" {
  ibmcloud_api_key = "YOUR_IBM_CLOUD_API_KEY"
  region         = "us-south"
}

# Create a Cloud Function
resource "ibm_cloud_function" "example" {
  name      = "my-function"
  runtime   = "nodejs-16"
  memory    = 128
  timeout    = 60
  code      = "// Your function code"
  trigger   = "http"
  location  = "us-south"
}

# Create a Service Key for the Cloud Function
resource "ibm_service_key" "example" {
  instance_id  = ibm_cloud_function.example.id
  service_name = "cloud-functions"
  roles        = ["Writer"]
  name          = "my-function-key"
}

  