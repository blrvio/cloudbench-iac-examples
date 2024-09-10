
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Cost Explorer report
resource "aws_costexplorer_report" "main" {
  name        = "my-cost-explorer-report"
  report_name = "MyCostReport"
  # Time period for the report
  time_period {
    start = "2023-01-01"
    end   = "2023-01-31"
  }
  # Report definition
  report_definition {
    # Include all costs
    include_period_over_period_change = true
    # Group costs by service
    group_by {
      type = "SERVICE"
    }
  }

  # Optional settings
  # compression = "GZIP" # Compress the report
  # s3_bucket_name = "my-s3-bucket" # Store the report in an S3 bucket
  # s3_prefix = "cost-reports" # Prefix for the S3 objects
  # format = "CSV" # Report format (CSV or JSON)
  # delivery_config {
  #   s3_delivery {
  #     s3_bucket_name = "my-s3-bucket"
  #     s3_prefix = "cost-reports"
  #   }
  # }
}

# Create an AWS Cost Explorer tag
resource "aws_costexplorer_tag" "main" {
  name    = "my-cost-explorer-tag"
  tag_key = "environment"
  # Define the tag values
  tag_values = ["dev", "prod"]
}
  