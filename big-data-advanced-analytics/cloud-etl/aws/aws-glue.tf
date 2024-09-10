
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create an AWS Glue Database
resource "aws_glue_database" "example" {
  name = "example_database"
}

# Create an AWS Glue Table
resource "aws_glue_table" "example" {
  database_name = aws_glue_database.example.name
  name          = "example_table"
  table_type    = "EXTERNAL_TABLE"
  # Set the table storage location (S3 bucket)
  storage_descriptor {
    location = "s3://my-bucket/my-data/"
    # Set the table data format
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    # Set the table serialization format
    serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
    # Define the table schema
    columns { 
      name = "id"
      type = "int"
    }
    columns { 
      name = "name"
      type = "string"
    }
    columns { 
      name = "timestamp"
      type = "timestamp"
    }
  }
  # Set the table partitioning details (optional)
  partition_keys { 
    name = "year"
    type = "int"
  }
}

# Create a AWS Glue Crawler
resource "aws_glue_crawler" "example" {
  name = "example_crawler"
  # Set the crawler database
  database_name = aws_glue_database.example.name
  # Set the crawler table
  table_name = aws_glue_table.example.name
  # Set the crawler role
  role_arn = "arn:aws:iam::123456789012:role/glue_service_role"
  # Set the crawler targets
  targets { 
    # Define the S3 target location for the crawler
    s3_targets {
      path = "s3://my-bucket/my-data/"
    }
  }
  # Set the crawler schedule
  schedule {
    schedule_expression = "cron(0 12 * * ? *)" # Crawl every day at 12:00PM UTC
  }
  # Set the crawler configuration
  configuration {
    # Enable crawler logging
    log_group_name = "my-glue-crawler-logs"
    # Set the crawler version (optional)
    version = "0.0.1"
  }
}

  