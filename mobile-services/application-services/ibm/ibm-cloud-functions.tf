
      # Configure o provedor do IBM Cloud
provider "ibm" {
  api_key = "your_ibm_cloud_api_key"
  region   = "us-south"
}

# Crie um namespace para as funções
resource "ibm_functions_namespace" "default" {
  name = "my-namespace"
}

# Crie uma função
resource "ibm_functions_action" "hello_world" {
  namespace = ibm_functions_namespace.default.name
  name       = "hello-world"
  runtime    = "nodejs:16"
  code       = "// Coloque o código da função aqui"
  kind       = "http"
}

# Crie um gatilho para a função
resource "ibm_functions_trigger" "hello_world_trigger" {
  namespace = ibm_functions_namespace.default.name
  action     = ibm_functions_action.hello_world.name
  kind       = "http"
}
    