
      # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Data Exchange
resource "aws_dataexchange_data_set" "example" {
  name  = "MyDataSet"
  arn   = "arn:aws:dataexchange:us-east-1:123456789012:dataset:ds-xxxxxxxxxxxx"

  revision {
    source_id = "ds-xxxxxxxxxxxx"
    description = "This is a description of the data set"
  }
}
    