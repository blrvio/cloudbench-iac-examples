
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Timestream database
resource "aws_timestream_database" "main" {
  database_name = "my-timestream-database"
  # Optional settings
  kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
  tags = {
    Name = "My Timestream Database"
  }
}

# Create a Timestream table
resource "aws_timestream_table" "main" {
  database_name = aws_timestream_database.main.database_name
  table_name    = "my-timestream-table"
  # Optional settings
  retention_properties {
    memory_store_retention_period_in_hours  = 24  # Keep data in memory for 24 hours
    magnetic_store_retention_period_in_days = 365 # Keep data in magnetic store for 365 days
  }
  # Define the time dimension
  time_dimension {
    name             = "time"
    time_column_name = "timestamp"
  }
  # Define the dimension attributes
  dimensions {
    name       = "region"
    value_type = "VARCHAR"
  }
  # Define the measure attributes
  measures {
    name       = "value"
    value_type = "DOUBLE"
  }
  # Add tags to the table
  tags = {
    Name = "My Timestream Table"
  }
}

# Create a Timestream write role
resource "aws_iam_role" "write" {
  name               = "timestream-write-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "timestream.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach a policy to the Timestream write role
resource "aws_iam_role_policy" "write" {
  name   = "timestream-write-policy"
  role   = aws_iam_role.write.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "timestream:WriteRecords",
        "timestream:DescribeEndpoints"
      ],
      "Resource": [
        "arn:aws:timestream:us-east-1:123456789012:database:my-timestream-database",
        "arn:aws:timestream:us-east-1:123456789012:table:my-timestream-database:my-timestream-table"
      ]
    }
  ]
}
EOF
}

# Create a Timestream read role
resource "aws_iam_role" "read" {
  name               = "timestream-read-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "timestream.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach a policy to the Timestream read role
resource "aws_iam_role_policy" "read" {
  name   = "timestream-read-policy"
  role   = aws_iam_role.read.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "timestream:DescribeEndpoints",
        "timestream:Select"
      ],
      "Resource": [
        "arn:aws:timestream:us-east-1:123456789012:database:my-timestream-database",
        "arn:aws:timestream:us-east-1:123456789012:table:my-timestream-database:my-timestream-table"
      ]
    }
  ]
}
EOF
}

  