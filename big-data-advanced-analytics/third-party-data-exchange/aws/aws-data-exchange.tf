
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Data Exchange
resource "aws_dataexchange_data_set" "main" {
  name  = "my-data-set"
  # The format of the data set.
  format = "CSV"
  # The type of data set.
  type    = "SAMPLE"
  # The description of the data set.
  description = "My sample data set"
  # The source of the data set.
  source = "S3"
  # The ARN of the AWS account that owns the data set.
  owner_account_id = "123456789012"
  # The Amazon S3 bucket where the data set is stored.
  s3_bucket = "my-bucket"
  # The Amazon S3 key where the data set is stored.
  s3_key = "my-key.csv"

  # Add the tags
  tags = {
    Name = "My Data Set"
  }
}

# Create a Data Exchange Asset
resource "aws_dataexchange_asset" "main" {
  data_set_id = aws_dataexchange_data_set.main.id
  name        = "my-asset"
  # The format of the asset.
  format = "CSV"
  # The type of asset.
  type = "SAMPLE"
  # The description of the asset.
  description = "My sample asset"
  # The source of the asset.
  source = "S3"
  # The ARN of the AWS account that owns the asset.
  owner_account_id = "123456789012"
  # The Amazon S3 bucket where the asset is stored.
  s3_bucket = "my-bucket"
  # The Amazon S3 key where the asset is stored.
  s3_key = "my-key.csv"

  # Add the tags
  tags = {
    Name = "My Asset"
  }
}

# Create a Data Exchange Revision
resource "aws_dataexchange_revision" "main" {
  asset_id     = aws_dataexchange_asset.main.id
  revision_type = "NEW"
  # The status of the revision.
  status = "DRAFT"
}

# Create a Data Exchange Environment
resource "aws_dataexchange_environment" "main" {
  name = "my-environment"
}

# Create a Data Exchange Provider
resource "aws_dataexchange_provider" "main" {
  name = "my-provider"
  # The AWS account ID of the provider.
  owner_account_id = "123456789012"
  # The ARN of the AWS account that owns the provider.
  owner_account_arn = "arn:aws:iam::123456789012:user/my-user"

  # Add the tags
  tags = {
    Name = "My Provider"
  }
}

# Create a Data Exchange Subscription
resource "aws_dataexchange_subscription" "main" {
  environment_id = aws_dataexchange_environment.main.id
  product_id    = aws_dataexchange_data_set.main.id
}

  