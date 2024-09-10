
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a QLDB ledger
resource "aws_qldb_ledger" "main" {
  name = "my-qldb-ledger" # Name of your QLDB ledger
  # Optional settings
  permissions_mode = "ALLOW_ALL" # Allow access to all users in the account by default
}

# Create a QLDB journal export
resource "aws_qldb_journal_export" "main" {
  name = "my-qldb-journal-export"
  ledger_name = aws_qldb_ledger.main.name # Name of the QLDB ledger
  # Optional settings
  export_configuration {
    s3_export_configuration {
      bucket = "my-s3-bucket" # Name of the S3 bucket for export
      prefix = "my-qldb-journal-export" # Prefix for the exported journal files
    }
  }
}

# Create a QLDB stream
resource "aws_qldb_stream" "main" {
  name = "my-qldb-stream"
  ledger_name = aws_qldb_ledger.main.name # Name of the QLDB ledger
  # Optional settings
  kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # KMS key ID for encryption
  # If you want to use default KMS key, leave this field empty
}

  