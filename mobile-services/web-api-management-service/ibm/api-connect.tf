
      # Configure o provedor do IBM Cloud
provider "ibm" {
  # Substitua pelo seu endpoint da API do IBM Cloud
  api_key = "your_api_key"
  # Substitua pelo seu ID do IBM Cloud
  account_id = "your_account_id"
  # Substitua pela região desejada
  region = "us-south"
}

# Crie um plano de API
resource "ibm_api_connect_plan" "example_plan" {
  # Substitua pelo ID do seu catálogo de APIs
  catalog_id = "your_catalog_id"
  # Substitua pelo nome do seu plano de API
  name = "example_plan"
  # Substitua pela descrição do seu plano de API
  description = "example plan description"
  # Define se o plano é público
  public = true
}

# Crie uma API
resource "ibm_api_connect_api" "example_api" {
  # Substitua pelo ID do seu catálogo de APIs
  catalog_id = "your_catalog_id"
  # Substitua pelo nome da sua API
  name = "example_api"
  # Substitua pela descrição da sua API
  description = "example api description"
  # Substitua pelo ID do seu plano de API
  plan_id = ibm_api_connect_plan.example_plan.id
}

# Crie um produto de API
resource "ibm_api_connect_product" "example_product" {
  # Substitua pelo nome do seu produto de API
  name = "example_product"
  # Substitua pela descrição do seu produto de API
  description = "example product description"
  # Substitua pelo ID do seu plano de API
  plan_id = ibm_api_connect_plan.example_plan.id
}

# Crie uma chave de API
resource "ibm_api_connect_api_key" "example_api_key" {
  # Substitua pelo ID do seu produto de API
  product_id = ibm_api_connect_product.example_product.id
  # Substitua pelo nome da sua chave de API
  name = "example_api_key"
}

# Crie uma política de segurança
resource "ibm_api_connect_security_policy" "example_security_policy" {
  # Substitua pelo ID do seu catálogo de APIs
  catalog_id = "your_catalog_id"
  # Substitua pelo nome da sua política de segurança
  name = "example_security_policy"
  # Substitua pela descrição da sua política de segurança
  description = "example security policy description"
  # Substitua pela string JSON da sua política de segurança
  policy_json = "your_policy_json"
}
    