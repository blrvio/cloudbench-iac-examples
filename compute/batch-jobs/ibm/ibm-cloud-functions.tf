
      # Configure o provedor do IBM Cloud
provider "ibm" {
  api_key = "your_api_key" # Substitua pela sua chave API do IBM Cloud
  region  = "us-south" # Substitua pela sua região desejada
}

# Crie um namespace para suas funções
resource "ibm_functions_namespace" "my_namespace" {
  name = "my_namespace"
}

# Crie uma função
resource "ibm_functions_action" "my_function" {
  name        = "my_function"
  namespace   = ibm_functions_namespace.my_namespace.id
  kind        = "nodejs:16"
  runtime     = "nodejs:16"
  code        = "// Código da função
console.log('Hello, world!');"
  memory      = 128
  timeout_sec = 60
}

# Crie um trigger para a função
resource "ibm_functions_trigger" "my_trigger" {
  namespace  = ibm_functions_namespace.my_namespace.id
  name       = "my_trigger"
  action_name = ibm_functions_action.my_function.id
  kind       = "http"
}
    