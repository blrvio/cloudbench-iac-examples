
      # Configure o provedor IBM Cloud
provider "ibm" {
  # Substitua pela sua região desejada
  region = "us-south"
}

# Crie um serviço API Connect
resource "ibm_api_connect_service" "api_connect" {
  name = "api_connect"
  # Substitua pelo seu plano desejado
  plan = "lite"
}

# Crie um catálogo de APIs
resource "ibm_api_connect_catalog" "api_catalog" {
  name = "api_catalog"
  service_id = ibm_api_connect_service.api_connect.id
  # Substitua pelo nome do seu espaço de trabalho
  workspace = "workspace"
}

# Importe uma definição de API
resource "ibm_api_connect_api" "imported_api" {
  name = "imported_api"
  catalog_id = ibm_api_connect_catalog.api_catalog.id
  # Substitua pelo caminho para o arquivo de definição da API
  definition = "path/to/api_definition.yaml"
}

# Crie um plano de API
resource "ibm_api_connect_plan" "api_plan" {
  name = "api_plan"
  catalog_id = ibm_api_connect_catalog.api_catalog.id
  api_id = ibm_api_connect_api.imported_api.id
  # Substitua pelo tipo de plano desejado
  type = "open"
}

# Crie uma chave de API
resource "ibm_api_connect_key" "api_key" {
  catalog_id = ibm_api_connect_catalog.api_catalog.id
  plan_id = ibm_api_connect_plan.api_plan.id
}
    