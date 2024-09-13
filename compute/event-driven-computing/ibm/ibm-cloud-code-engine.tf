
      # Configure o provedor IBM Cloud
provider "ibm" {
  region = "us-south"
  api_key = "YOUR_API_KEY"
}

# Crie um serviço Code Engine
resource "ibm_codeengine_service" "my_service" {
  name        = "my-service"
  location    = "us-south"
  runtime     = "nodejs-16"
  git_source  = "https://github.com/your-username/your-repo.git"
}

# Crie uma versão do serviço
resource "ibm_codeengine_version" "my_version" {
  service_name = ibm_codeengine_service.my_service.name
  version      = "1.0.0"
  image        = "us-south.icr.io/your-namespace/your-image:latest"
}

# Crie uma rota para o serviço
resource "ibm_codeengine_route" "my_route" {
  service_name = ibm_codeengine_service.my_service.name
  domain       = "my-domain.com"
  path         = "/"
}

# Crie um recurso para o serviço
resource "ibm_codeengine_resource" "my_resource" {
  service_name = ibm_codeengine_service.my_service.name
  name         = "my-resource"
  type         = "deployment"
  limits       = {
    cpu   = 1
    memory = 1024
  }
}

    