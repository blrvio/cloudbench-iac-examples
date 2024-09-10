
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a managed service using AWS Service Catalog
resource "aws_service_catalog_product" "main" {
  name  = "my-managed-service" # Name of your managed service
  owner = "your-account-id"    # Your AWS account ID
  # Define the provisioning artifact for the managed service
  provisioning_artifact {
    name        = "default"
    type        = "CLOUDFORMATION"
    description = "Default provisioning artifact"
    # Specify the CloudFormation template for the managed service
    template_url = "https://s3.amazonaws.com/your-bucket-name/my-managed-service.yaml"
  }

  # Define the access policy for the managed service
  # Users with access to this policy can provision the managed service
  access_policy {
    # Example access policy for a specific AWS account
    account_id = "your-account-id"
    # Grant access to all actions
    actions = ["*"]
  }
}

# Create a portfolio for the managed service
resource "aws_service_catalog_portfolio" "main" {
  name          = "my-portfolio" # Name of your portfolio
  provider_name = "AWS Managed Services"
  # Define the provisioning artifact for the managed service
  provisioning_artifact {
    name        = "default"
    type        = "CLOUDFORMATION"
    description = "Default provisioning artifact"
    # Specify the CloudFormation template for the managed service
    template_url = "https://s3.amazonaws.com/your-bucket-name/my-managed-service.yaml"
  }
}

# Add the managed service to the portfolio
resource "aws_service_catalog_portfolio_product" "main" {
  portfolio_id = aws_service_catalog_portfolio.main.id
  product_id   = aws_service_catalog_product.main.id
}

  