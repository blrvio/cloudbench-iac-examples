
      # Configure o provedor (substitua pela sua plataforma)
provider "<provider_name>" {
  # Configurações específicas do provedor
}

# Crie um repositório de contêineres
resource "<provider_name>_container_registry" "my_registry" {
  name = "my-registry"
  # Outros atributos específicos da plataforma
}

# Crie uma imagem de contêiner
resource "<provider_name>_container_image" "my_image" {
  name       = "my-image"
  registry   = <provider_name>_container_registry.my_registry.name
  source     = "<path_to_your_image_file>" # Substitua pelo caminho da imagem
  # Outros atributos específicos da plataforma
}
    