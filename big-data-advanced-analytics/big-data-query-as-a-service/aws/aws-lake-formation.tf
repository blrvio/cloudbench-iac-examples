
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Lake Formation Data Catalog
resource "aws_lakeformation_data_catalog" "main" {
  name = "my-data-catalog"
}

# Create a Lake Formation Role
resource "aws_lakeformation_role" "main" {
  name = "my-lake-formation-role"
  # Create a new IAM role for Lake Formation
  role_arn = aws_iam_role.lakeformation_role.arn
}

# Create an IAM Role
resource "aws_iam_role" "lakeformation_role" {
  name = "lakeformation-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lakeformation.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Create a Lake Formation Policy
resource "aws_lakeformation_policy" "main" {
  name = "my-lakeformation-policy"
  # Define the policy statement
  statement {
    # Create a statement that allows a role to read data
    principal {
      # The principal is the role created above
      aws_account_id = "123456789012"
    }
    action {
      # The action is to read data
      "READ_DATA"
    }
    resource {
      # The resource is a specific table in S3
      # Replace with your actual S3 path
      database_name = "my-database"
      table_name = "my-table"
    }
  }
}

# Create a Lake Formation Data Location
resource "aws_lakeformation_data_location" "main" {
  data_location_arn = "arn:aws:s3:::my-bucket/my-data"
  # Set the catalog id to the created catalog
  catalog_id = aws_lakeformation_data_catalog.main.id
}

  