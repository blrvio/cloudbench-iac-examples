
      # Configure o provedor Oracle Cloud
provider "oci" {
  # Configure as credenciais do seu provedor
}

# Crie um bucket para o armazenamento de objetos
resource "oci_objectstorage_bucket" "bucket" {
  name     = "my-infrequent-access-bucket"
  namespace = "oci"
  storage_tier = "INFREQUENT_ACCESS"
}

# Crie um objeto dentro do bucket
resource "oci_objectstorage_object" "object" {
  bucket  = oci_objectstorage_bucket.bucket.name
  namespace = oci_objectstorage_bucket.bucket.namespace
  name = "my-object"
  content = "This is a sample object"
}

    