
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  user    = "ocid1.user.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  key     = "your_api_key"
  fingerprint = "your_fingerprint"
}

# Crie um bucket de armazenamento de arquivos
resource "oci_archive_bucket" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  name           = "example-bucket"
  storage_tier   = "ARCHIVE"
}

# Crie um objeto de armazenamento de arquivos
resource "oci_archive_object" "example" {
  bucket          = oci_archive_bucket.example.name
  compartment_id  = oci_archive_bucket.example.compartment_id
  name           = "example-object"
  source         = "path/to/your/object"
}

    