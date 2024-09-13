
      # Configure o provedor do IBM Cloud
provider "ibm" {
  region    = "us-south"
  api_key  = "xxxxxxxx"
  account_id = "xxxxxxxx"
}

# Crie um serviço Code Engine
resource "ibm_codeengine_service" "my_service" {
  name        = "my-service"
  location    = "us-south"
  runtime     = "nodejs-16"
  git_source  = {
    url = "https://github.com/example/my-app"
  }
  build_config = {
    type = "docker"
    dockerfile = "Dockerfile"
  }
}

# Crie um deployment
resource "ibm_codeengine_deployment" "my_deployment" {
  name           = "my-deployment"
  service_name  = ibm_codeengine_service.my_service.id
  scale_strategy = "auto"
  replicas = 1
}

# Crie uma rota
resource "ibm_codeengine_route" "my_route" {
  name             = "my-route"
  deployment_name  = ibm_codeengine_deployment.my_deployment.id
  host             = "my-app.example.com"
  route_type        = "http"
}

    