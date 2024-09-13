
      # Configure o provedor do Oracle Cloud
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  # Substitua pelo caminho da chave privada do usuário.
  key_file = "path/to/your/private/key.pem"
  # Substitua pelo caminho do arquivo de configuração do usuário.
  config_file = "path/to/your/config.json"
}

# Crie uma regra de Cloud Guard
resource "oci_cloud_guard_detector_recipe" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  display_name   = "My Detector Recipe"
  description    = "A custom detector recipe for my environment"

  detector_rule {
    name = "Example Rule"
    # ...
  }
}

# Crie um detector
resource "oci_cloud_guard_detector" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  display_name   = "My Detector"
  description    = "A custom detector for my environment"
  detector_recipe_id = oci_cloud_guard_detector_recipe.example.id
  target_type  = "COMPARTMENT"
  target_value = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
    