
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a cost allocation tag
resource "aws_cost_allocation_tag" "main" {
  name     = "MyCostAllocationTag"
  value    = "Development"
  tag_type = "user"
}

# Create a cost category
resource "aws_cost_category" "main" {
  name = "MyCostCategory"
  rules { # Define rules for cost categorization
    rule_name = "MyRuleName"
    dimension_values = [
      {
        key   = "SERVICE"
        value = "AmazonEC2"
      }
    ]
    rule_type = "COST_CATEGORY_RULE_TYPE_MATCHING"
  }
}

# Create a cost explorer report
resource "aws_cost_explorer_report" "main" {
  name                        = "MyCostExplorerReport"
  report_name                 = "MyReportName"
  time_unit                   = "MONTHLY"
  report_generation_frequency = "DAILY"
  report_schedule { # Define schedule for report generation
    schedule_frequency = "DAILY"
    schedule_time      = "00:00"
    # Define the report delivery configuration
    delivery_config {
      s3_bucket = "my-s3-bucket"
      # Optional: Define the report format
      # report_format = "CSV"
      # Optional: Define the report destination
      # destination_type = "S3"
      # Optional: Define the report query
      # query { # Define query criteria for the report
      #   time_period {
      #     start  = "2023-01-01"
      #     end    = "2023-01-31"
      #   }
      #   # Define the report dimension
      #   dimension { # Define the dimension of the report
      #     key = "SERVICE"
      #     values = ["AmazonEC2"]
      #   }
      # }
    }
  }
}

  