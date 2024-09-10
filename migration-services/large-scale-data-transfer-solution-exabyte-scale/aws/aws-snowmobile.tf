
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Snowmobile job
resource "aws_snowmobile_job" "main" {
  address  = "your_address" # Replace with your address
  contact  = "your_contact" # Replace with your contact information
  description = "My Snowmobile job" # Replace with a description
  job_size = "10TB" # Replace with the desired job size
  # Optional parameters
  # delivery_manifest_file = "path/to/your/manifest.json"
  # kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
  # tags = {
  #   Name = "My Snowmobile Job"
  # }
}

# Create a Snowmobile shipping instruction
resource "aws_snowmobile_shipping_instruction" "main" {
  job_id = aws_snowmobile_job.main.id # ID of the Snowmobile job
  # Optional parameters
  # shipping_instruction_type = "standard" # Use standard shipping
  # country = "US" # Replace with your country
  # address_lines = ["Address line 1", "Address line 2"] # Replace with your address lines
  # city = "Your city" # Replace with your city
  # state = "Your state" # Replace with your state
  # postal_code = "Your postal code" # Replace with your postal code
  # contact_phone_number = "Your phone number" # Replace with your phone number
  # contact_email = "your_email@example.com" # Replace with your email
}

  