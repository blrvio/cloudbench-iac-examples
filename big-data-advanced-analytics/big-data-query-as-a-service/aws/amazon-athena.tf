
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Athena database
resource "aws_athena_database" "main" {
  name = "my_database" # Name of your Athena database
}

# Create an Athena table
resource "aws_athena_table" "main" {
  database = aws_athena_database.main.name
  name     = "my_table"
  # Define the table schema
  table_definition = <<EOF
CREATE EXTERNAL TABLE my_table(
  column_name1 STRING,
  column_name2 INT
)
STORED AS PARQUET
LOCATION 's3://my-bucket/data/'
EOF
}

# Create an Athena workgroup
resource "aws_athena_workgroup" "main" {
  name = "my_workgroup"
  # Configure the workgroup properties
  configuration {
    # Set the result configuration
    result_configuration {
      # Configure the output location for query results
      output_location = "s3://my-bucket/results/"
    }
  }
  # Add the database to the workgroup
  state="ENABLED"
  tags = {
    Name = "My Athena Workgroup"
  }
}

  