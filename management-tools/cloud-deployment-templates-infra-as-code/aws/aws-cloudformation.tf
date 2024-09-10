
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Define a CloudFormation Stack
resource "aws_cloudformation_stack" "main" {
  name          = "my-cloudformation-stack" # Name of your CloudFormation stack
  template_body = <<EOF
  # Define the CloudFormation template here.
  # Example using a simple S3 bucket
  Resources:
    MyBucket:
      Type: 'AWS::S3::Bucket'
      Properties:
        BucketName: MyBucket
  EOF

  # Optional: Define parameters to pass to the template
  # parameters = {
  #   MyParameter: "my-parameter-value"
  # }

  # Optional: Define tags for the stack
  # tags = {
  #   Name = "My CloudFormation Stack"
  # }
}

# Define an S3 Bucket (optional, if used in the template)
# resource "aws_s3_bucket" "my_bucket" {
#   bucket = "my-bucket-name"
#   acl    = "private"
# }

  