
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1" # Substitua pela sua região desejada
  # ... outras configurações
}

# Crie uma regra de balanceamento de carga
resource "oci_load_balancer_rule" "example_rule" {
  load_balancer_id = oci_load_balancer.example_lb.id # ID do balanceador de carga
  name             = "example-rule"
  backend_sets     = [oci_load_balancer_backend_set.example_backend_set.id] # ID do conjunto de backends
  http_options     = {
    path  = "/" # Caminho para o backend
    method = "GET" # Método HTTP
  }
}

# Crie um conjunto de backends
resource "oci_load_balancer_backend_set" "example_backend_set" {
  load_balancer_id = oci_load_balancer.example_lb.id # ID do balanceador de carga
  name             = "example-backend-set"

  backend {
    subnet_id = oci_core_subnet.example_subnet.id # ID da subnet
    ip_address = "10.0.0.10" # Endereço IP do backend
  }
}

# Crie um balanceador de carga
resource "oci_load_balancer" "example_lb" {
  name = "example-lb"
  # ... outras configurações
}
    