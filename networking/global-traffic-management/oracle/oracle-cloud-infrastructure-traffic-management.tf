
      # Configure o provedor Oracle Cloud Infrastructure
provider "oci" {
  # Substitua pelas suas credenciais
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaw766w5678"
  user_ocid  = "ocid1.user.oc1..aaaaaaaay766w5678"
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxx"
}

# Crie um balanceador de carga
resource "oci_load_balancer" "example" {
  # Substitua pelos seus valores
  name             = "my-load-balancer"
  shape             = "SILVER"
  subnet_ids        = ["ocid1.subnet.oc1..aaaaaaaax766w5678"]
  availability_domain = "us-ashburn-1a"
}

# Crie um backend set
resource "oci_load_balancer_backend_set" "example" {
  # Substitua pelos seus valores
  load_balancer_id = oci_load_balancer.example.id
  name             = "my-backend-set"
  backend_servers { # Defina os seus servidores backend
    name   = "example"
    ip     = "10.0.0.1"
    port   = "80"
    weight = 10
  }
}

# Crie uma regra de balanceamento de carga
resource "oci_load_balancer_rule" "example" {
  # Substitua pelos seus valores
  load_balancer_id = oci_load_balancer.example.id
  name             = "my-load-balancer-rule"
  backend_set_id   = oci_load_balancer_backend_set.example.id
  # Defina a regra de balanceamento (por exemplo, round robin, least connections)
  policy           = "ROUND_ROBIN"
  # Defina o host e o caminho a serem balanceados
  match_conditions { # Defina as condições de correspondência
    host       = "www.example.com"
    path       = "/"
    method     = "GET"
  }
}

    