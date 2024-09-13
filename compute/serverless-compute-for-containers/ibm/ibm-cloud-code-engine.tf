
      # Configure o provedor do IBM Cloud
provider "ibm" {
  api_key = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # Substitua pela sua API Key
  region  = "us-south" # Substitua pela sua região desejada
}

# Crie um namespace para o Code Engine
resource "ibm_code_engine_namespace" "main" {
  name     = "my-namespace"
  location = ibm_code_engine_location.main.id
}

# Crie um local para o Code Engine
resource "ibm_code_engine_location" "main" {
  name = "us-south"
}

# Crie um serviço Code Engine
resource "ibm_code_engine_service" "main" {
  namespace_id = ibm_code_engine_namespace.main.id
  name        = "my-service"
  runtime     = "nodejs-16"
  memory      = "1Gi"
  cpu         = 1
}

# Crie uma imagem do Docker
resource "ibm_code_engine_image" "main" {
  service_id = ibm_code_engine_service.main.id
  name        = "my-image"
  tag         = "latest"
}

# Crie uma rota para o serviço
resource "ibm_code_engine_route" "main" {
  service_id = ibm_code_engine_service.main.id
  name        = "my-route"
}

    