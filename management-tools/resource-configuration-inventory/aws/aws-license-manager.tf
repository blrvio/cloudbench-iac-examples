
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a License Manager Association
resource "aws_licensemanager_association" "main" {
  # The ID of the license configuration to associate.
  license_configuration_arn = "arn:aws:license-manager:us-east-1:123456789012:licenseconfiguration:lic-01234567890abcdef0
  # The ID of the resource to associate.
  resource_arn = "arn:aws:ec2:us-east-1:123456789012:instance/i-0123456789abcdef0"
}

# Create a License Manager License Configuration
resource "aws_licensemanager_license_configuration" "main" {
  # A description of the license configuration.
  description = "My License Configuration"
  # The license counting operation for the license configuration.
  license_counting_operation = "COUNT_ONLY"
  # A list of the resource types that are associated with the license configuration.
  # Supported values:  EC2_INSTANCE, EC2_HOST, RDS_INSTANCE
  resource_types = ["EC2_INSTANCE"]
  # The number of licenses that are managed by the license configuration.
  # This value is only applicable to bring your own license (BYOL) licenses.
  license_count = 1
  # The name of the license configuration.
  name = "My License Configuration"
}

# Create a License Manager License
resource "aws_licensemanager_license" "main" {
  # The license name.
  name = "My License"
  # The license key of the license. This value is required if you're using a BYOL license.
  license_key = "license-key"
}

# Create a License Manager License Consumption
resource "aws_licensemanager_license_consumption" "main" {
  # The ID of the license configuration to use for license consumption.
  license_configuration_arn = "arn:aws:license-manager:us-east-1:123456789012:licenseconfiguration:lic-01234567890abcdef0
  # The ARN of the resource to consume the license.
  resource_arn = "arn:aws:ec2:us-east-1:123456789012:instance/i-0123456789abcdef0"
}

# Create a License Manager License Grant
resource "aws_licensemanager_license_grant" "main" {
  # The ID of the license configuration to use for the license grant.
  license_configuration_arn = "arn:aws:license-manager:us-east-1:123456789012:licenseconfiguration:lic-01234567890abcdef0
  # The ID of the license to grant.
  license_arn = "arn:aws:license-manager:us-east-1:123456789012:license:lic-01234567890abcdef0
  # The ARN of the recipient of the license grant.
  recipient_arn = "arn:aws:iam::123456789012:user/my-user"
}

  