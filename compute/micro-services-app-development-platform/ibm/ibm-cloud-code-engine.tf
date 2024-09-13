
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "YOUR_API_KEY"
  region  = "us-south"
}

# Crie um namespace para o Code Engine
resource "ibm_codeengine_namespace" "my_namespace" {
  name = "my-namespace"
  location = "us-south"
}

# Crie um serviço Code Engine
resource "ibm_codeengine_service" "my_service" {
  name = "my-service"
  namespace_id = ibm_codeengine_namespace.my_namespace.id
  runtime = "nodejs-16"
  image = "us-docker.pkg.dev/cloudrun/container/nodejs"
  replicas = 1
  timeout_seconds = 120
  memory = "1Gi"
}

# Crie um roteamento para o serviço Code Engine
resource "ibm_codeengine_route" "my_route" {
  name = "my-route"
  namespace_id = ibm_codeengine_namespace.my_namespace.id
  service_name = ibm_codeengine_service.my_service.name
  domain = "my-domain.com"
  path = "/"
}

    