
      # Configure o provedor do IBM Cloud
provider "ibm" {
  # Substitua pela sua região desejada
  region = "us-south"
}

# Crie um serviço Code Engine
resource "ibm_codeengine_service" "my_codeengine_service" {
  name     = "my-codeengine-service"
  location = ibm_codeengine_location.my_location.id
}

# Crie uma localização para o serviço Code Engine
resource "ibm_codeengine_location" "my_location" {
  name = "us-south"
}

# Crie um aplicativo Code Engine
resource "ibm_codeengine_application" "my_application" {
  name          = "my-codeengine-app"
  location      = ibm_codeengine_location.my_location.id
  service_name = ibm_codeengine_service.my_codeengine_service.id
  runtime       = "nodejs-16"

  build {
    # Substitua pelo caminho para o seu código-fonte
    context = "path/to/your/code"
    # Substitua pelo comando de build, se necessário
    command = "npm install && npm run build"
  }

  spec {
    containers {
      # Substitua pelo nome da sua imagem do Docker
      image = "my-docker-image:latest"
    }
  }
}

# Crie um roteamento para o aplicativo Code Engine
resource "ibm_codeengine_route" "my_route" {
  name          = "my-codeengine-route"
  location      = ibm_codeengine_location.my_location.id
  service_name = ibm_codeengine_service.my_codeengine_service.id
  application_name = ibm_codeengine_application.my_application.name

  spec {
    # Substitua pelo nome de host desejado
    host = "my-codeengine-app.example.com"
  }
}
    