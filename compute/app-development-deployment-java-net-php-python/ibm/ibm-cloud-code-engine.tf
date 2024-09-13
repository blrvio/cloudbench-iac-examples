
      # Configure o provedor do IBM Cloud
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY" # Substitua pela sua chave de API do IBM Cloud
  region   = "us-south" # Substitua pela sua região desejada
}

# Crie um namespace do Code Engine
resource "ibm_codeengine_namespace" "example" {
  name     = "my-namespace"
  location = "us-south"
}

# Crie uma aplicação no Code Engine
resource "ibm_codeengine_app" "example" {
  namespace = ibm_codeengine_namespace.example.id
  name      = "my-app"

  runtime  = "nodejs-16"
  git_source {
    url = "https://github.com/your-username/your-repository.git"
  }
}

# Crie um serviço no Code Engine
resource "ibm_codeengine_service" "example" {
  app_name    = ibm_codeengine_app.example.name
  namespace   = ibm_codeengine_namespace.example.id
  name       = "my-service"
  route       = "my-route"
  port        = 3000
  autoscaling {
    min_replicas = 1
    max_replicas = 3
  }
}
    