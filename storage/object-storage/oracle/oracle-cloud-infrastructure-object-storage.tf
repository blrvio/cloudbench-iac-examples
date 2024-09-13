
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1"
  # Substitua pela sua região desejada
  # Adicione as credenciais necessárias
}

# Crie um bucket de armazenamento de objetos
resource "oci_objectstorage_bucket" "my_bucket" {
  namespace = "my-namespace"
  # Substitua pelo namespace desejado
  name     = "my-bucket"
  # Substitua pelo nome do bucket desejado
}

# Carregue um objeto para o bucket
resource "oci_objectstorage_object" "my_object" {
  bucket   = oci_objectstorage_bucket.my_bucket.name
  namespace = oci_objectstorage_bucket.my_bucket.namespace
  name     = "my-object"
  # Substitua pelo nome do objeto desejado
  source   = "path/to/my-object"
  # Substitua pelo caminho do arquivo local
}

    