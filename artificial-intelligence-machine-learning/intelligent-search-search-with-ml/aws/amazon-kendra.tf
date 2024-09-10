
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create an Amazon Kendra Index
resource "aws_kendra_index" "main" {
  name     = "my-kendra-index"
  role_arn = aws_iam_role.kendra_role.arn
  edition  = "DEVELOPER"
  # Configure the data source
  # For this example, we'll use a S3 data source
  # You can replace this with other supported data sources
  # like Amazon DocumentDB, or custom document sources
  # See the AWS documentation for more details
  data_source_config {
    s3_configuration {
      bucket_name = "my-s3-bucket"
      # Optional configuration for specific document types
      # See the AWS documentation for more details
      # document_metadata_configuration {
      #   s3_prefix = "my/documents/prefix"
      # }
    }
  }
}

# Create an IAM Role for Kendra
resource "aws_iam_role" "kendra_role" {
  name = "kendra-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "kendra.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Create an IAM Policy for Kendra
resource "aws_iam_policy" "kendra_policy" {
  name = "kendra-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::my-s3-bucket/*"
        ]
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "kendra_role_policy_attachment" {
  role       = aws_iam_role.kendra_role.name
  policy_arn = aws_iam_policy.kendra_policy.arn
}

# Create an Amazon Kendra User
resource "aws_kendra_user" "main" {
  index_id = aws_kendra_index.main.id
  user_name = "my-kendra-user"
  # Specify the permissions for the user
  # See the AWS documentation for more details
  # permissions_configuration {
  #   allow_query = true
  #   allow_suggest = true
  #   allow_query_suggestions = true
  # }
}

# Create an Amazon Kendra Query
# You can use the `aws_kendra_query` resource to create a query
# that you can then use to search your index
# See the AWS documentation for more details
# resource "aws_kendra_query" "main" {
#   index_id = aws_kendra_index.main.id
#   query_text = "Amazon Web Services"
#   # Additional query options can be specified
#   # See the AWS documentation for more details
#   # query_options {
#   #   # ...
#   # }
# }

  