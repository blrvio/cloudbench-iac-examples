
      # Configure o provedor do IBM Cloud
provider "ibm" {
  region = "us-south"
}

# Crie um namespace do Code Engine
resource "ibm_codeengine_namespace" "my_namespace" {
  name     = "my-namespace"
  location = ibm_codeengine_namespace.my_namespace.location
}

# Crie um aplicativo no Code Engine
resource "ibm_codeengine_application" "my_app" {
  name       = "my-app"
  namespace  = ibm_codeengine_namespace.my_namespace.name
  runtime    = "nodejs-16"
  build_source {
    context = "https://github.com/ibm-cloud/code-engine-samples.git"
    branch  = "main"
  }
}

# Crie um serviço no Code Engine
resource "ibm_codeengine_service" "my_service" {
  name       = "my-service"
  namespace  = ibm_codeengine_namespace.my_namespace.name
  application = ibm_codeengine_application.my_app.name
}
    