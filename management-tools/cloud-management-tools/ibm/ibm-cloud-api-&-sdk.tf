
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key  = "YOUR_IBM_CLOUD_API_KEY"
  region   = "us-south"
}

# Crie um serviço de API
resource "ibm_api_service" "my_api_service" {
  name = "my-api-service"
  plan = "basic"
  # ... outros atributos
}

# Crie uma chave de API
resource "ibm_api_key" "my_api_key" {
  service_id = ibm_api_service.my_api_service.id
  # ... outros atributos
}
    