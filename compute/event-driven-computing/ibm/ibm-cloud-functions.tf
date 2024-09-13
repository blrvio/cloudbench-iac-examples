
      # Configure o provedor IBM Cloud
provider "ibm" {
  region = "us-south"
}

# Crie um namespace para as funções
resource "ibm_functions_namespace" "my_namespace" {
  name     = "my-namespace"
  location = "us-south"
}

# Crie uma função
resource "ibm_functions_action" "my_function" {
  namespace = ibm_functions_namespace.my_namespace.id
  name       = "my-function"
  runtime    = "nodejs:16"

  memory = 128

  code = <<EOF
const { Response } = require('ibm-functions');

module.exports = (params) => {
  const name = params.name || 'World';
  return new Response(`Hello ${name}!`);
};
EOF
}

# Crie uma regra de invocação da função
resource "ibm_functions_invoke" "my_invoke" {
  namespace = ibm_functions_namespace.my_namespace.id
  action    = ibm_functions_action.my_function.id
  route     = "my-route"
}

    