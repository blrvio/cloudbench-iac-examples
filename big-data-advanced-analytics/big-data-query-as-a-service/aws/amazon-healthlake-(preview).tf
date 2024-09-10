
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a HealthLake data store
resource "aws_healthlake_datastore" "main" {
  name             = "my-healthlake-datastore"
  datastore_type   = "FHIR_v4" # Data store type
  data_store_size   = 10 # Data store size in GB
  sse_configuration {
    kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # KMS key ID for encryption
  }
  # Tags for the data store
  tags = {
    Name = "My HealthLake Data Store"
  }
}

# Create a HealthLake FHIR store
resource "aws_healthlake_fhir_store" "main" {
  datastore_id = aws_healthlake_datastore.main.id # ID of the data store
  name          = "my-fhir-store"
  # Tags for the FHIR store
  tags = {
    Name = "My FHIR Store"
  }
}

# Import FHIR data into the FHIR store
resource "aws_healthlake_fhir_data" "main" {
  fhir_store_id = aws_healthlake_fhir_store.main.id # ID of the FHIR store
  data_format    = "ndjson" # Data format
  # You can specify a S3 bucket and object key or a pre-signed URL
  # For S3 bucket
  s3_uri = "s3://my-bucket/my-fhir-data.ndjson"
  # For pre-signed URL
  # pre_signed_url = "https://..."
  # Tags for the FHIR data
  tags = {
    Name = "My FHIR Data"
  }
}

# You can also use the AWS HealthLake API to import FHIR data into the FHIR store
# Refer to the AWS HealthLake documentation for more details: https://docs.aws.amazon.com/healthlake/latest/developerguide/import-fhir.html

  