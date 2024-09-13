
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "your_api_key" # Substitua pela sua API Key
  region  = "us-south" # Substitua pela sua região desejada
}

# Crie um serviço Code Engine
resource "ibm_codeengine_service" "my_service" {
  name     = "my-service"
  location = "us-south"
}

# Crie um aplicativo Code Engine
resource "ibm_codeengine_application" "my_app" {
  name           = "my-app"
  service_name   = ibm_codeengine_service.my_service.id
  runtime        = "nodejs-16"
  build_command  = "npm install"
  start_command  = "npm start"
  source_location = "https://github.com/your-username/your-repo.git"
}

# Crie um roteamento para o aplicativo Code Engine
resource "ibm_codeengine_route" "my_route" {
  name        = "my-route"
  service_name = ibm_codeengine_service.my_service.id
  application_name = ibm_codeengine_application.my_app.id
  rules = [{path: "/*", application: ibm_codeengine_application.my_app.id}]
}
    