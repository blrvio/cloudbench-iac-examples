
      # Configure o provedor do IBM Cloud
provider "ibm" {
  api_key = "<your_ibm_cloud_api_key>
  region  = "<your_ibm_cloud_region>"
}

# Crie um repositório de contêineres
resource "ibm_container_registry_repository" "my_repo" {
  name   = "my_repo"
  namespace = "<your_ibm_cloud_namespace>"
}

# Importe uma imagem de contêiner
resource "ibm_container_registry_image" "my_image" {
  repository = ibm_container_registry_repository.my_repo.name
  namespace  = ibm_container_registry_repository.my_repo.namespace
  source     = "<your_docker_hub_image_name>"
}

# Publique uma imagem de contêiner
resource "ibm_container_registry_image" "my_image" {
  repository = ibm_container_registry_repository.my_repo.name
  namespace  = ibm_container_registry_repository.my_repo.namespace
  source     = "<your_local_image_path>"
}

    