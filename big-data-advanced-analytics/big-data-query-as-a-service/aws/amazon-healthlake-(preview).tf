
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Data Lake para armazenar dados de saúde
resource "aws_healthlake_data_lake" "example" {
  name = "healthlake-datalake"
  kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/xxxxxxxxxxxxxxxxxxxxxxxx"
  data_lake_storage_type = "S3"
  data_lake_storage_path = "s3://my-healthlake-bucket"
}

# Crie um FHIR Data Store para armazenar dados FHIR
resource "aws_healthlake_fhir_datastore" "example" {
  name = "healthlake-fhir-datastore"
  data_lake_id = aws_healthlake_data_lake.example.id
  fhir_version = "R4"
  preferred_name = "example-datastore"
  predefined_data_format = "FHIR"
  datastore_type = "FHIR_STORE"
}

# Crie uma regra de acesso para controlar o acesso aos seus dados de saúde
resource "aws_healthlake_data_access_policy" "example" {
  name = "healthlake-access-policy"
  data_lake_id = aws_healthlake_data_lake.example.id
  access_pattern = "ALL"
  allow_all_object_access = true
}
    