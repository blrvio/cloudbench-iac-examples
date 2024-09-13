
      # Configure o provedor Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1" # Substitua pela sua região desejada
  # Adicione credenciais de autenticação
}

# Crie um namespace para as funções
resource "oci_functions_namespace" "example_namespace" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaa" # Substitua pelo ID do seu compartimento
  display_name   = "example-namespace"
}

# Crie uma função
resource "oci_functions_function" "example_function" {
  namespace_id  = oci_functions_namespace.example_namespace.id
  display_name = "example-function"
  # Adicione o código da função
}

# Crie um endpoint para a função
resource "oci_functions_function_endpoint" "example_endpoint" {
  function_id = oci_functions_function.example_function.id
  # Adicione configurações adicionais do endpoint
}
    