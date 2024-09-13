
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "<YOUR_IBM_API_KEY>" # Substitua pela sua chave API do IBM Cloud
  region  = "us-south" # Substitua pela sua região desejada
}

# Crie um namespace para a função
resource "ibm_functions_namespace" "my_namespace" {
  name = "my-namespace"
}

# Crie uma ação de função
resource "ibm_functions_action" "my_action" {
  name         = "my-action"
  runtime      = "nodejs:16"
  namespace_id = ibm_functions_namespace.my_namespace.id
  code         = "// Código da função
console.log('Hello, world!');"
}

# Crie uma regra de gatilho HTTP
resource "ibm_functions_trigger_http" "my_trigger" {
  name         = "my-trigger"
  action_id    = ibm_functions_action.my_action.id
  namespace_id = ibm_functions_namespace.my_namespace.id
  method       = "GET"
  path         = "/hello"
}
    