
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Service Catalog Portfolio
resource "aws_servicecatalog_portfolio" "main" {
  name = "MyPortfolio"
  # Optional: Provider details for the portfolio
  provider_name = "MyProvider"
  # Optional: Description of the portfolio
  description = "My Portfolio Description"
}

# Create a Service Catalog Product
resource "aws_servicecatalog_product" "main" {
  name         = "MyProduct"
  portfolio_id = aws_servicecatalog_portfolio.main.id
  # Specify the type of product (e.g., "CLOUDFORMATION",
  # "MARKETPLACE", "AWS_SOLUTION_SPACE")
  product_type = "CLOUDFORMATION"
  provisioning_artifact_parameters {
    # The ID of the provisioning artifact to use for this product
    # Replace with the actual provisioning artifact ID
    id = "example_artifact_id"
  }
  # Optional: Description of the product
  description = "My Product Description"
  # Optional: A URL for the product documentation
  documentation_url = "https://example.com/product-documentation"
  # Optional: Tags to apply to the product
  tags = {
    Name = "MyProduct"
  }
}

# Create a Service Catalog Provisioning Artifact
resource "aws_servicecatalog_provisioning_artifact" "main" {
  name = "MyProvisioningArtifact"
  # The ID of the product to which this artifact belongs
  product_id = aws_servicecatalog_product.main.id
  # The type of provisioning artifact (e.g., "CLOUDFORMATION", "MARKETPLACE")
  type = "CLOUDFORMATION"
  # The version of the provisioning artifact
  version = "1.0"
  # Optional: Description of the provisioning artifact
  description = "My Provisioning Artifact Description"
}

# Create a Service Catalog Provisioned Product
resource "aws_servicecatalog_provisioned_product" "main" {
  name       = "MyProvisionedProduct"
  product_id = aws_servicecatalog_product.main.id
  # The ID of the provisioning artifact to use
  provisioning_artifact_id = aws_servicecatalog_provisioning_artifact.main.id
  # The user or role that will have access to the provisioned product
  # (e.g., "arn:aws:iam::123456789012:user/user1")
  provisioned_product_owner = "arn:aws:iam::123456789012:user/user1"
  # Optional: The path to the provisioned product
  path = "path/to/provisioned/product"
  # Optional: Tags to apply to the provisioned product
  tags = {
    Name = "MyProvisionedProduct"
  }
}

# Create a Service Catalog Tag Option
resource "aws_servicecatalog_tag_option" "main" {
  name = "MyTagOption"
  # The key for the tag option
  key = "Environment"
  # The values for the tag option
  values = ["Production", "Development", "Staging"]
  # Optional: Description of the tag option
  description = "My Tag Option Description"
}

# Create a Service Catalog Tag Option for a Portfolio
resource "aws_servicecatalog_tag_option_for_portfolio" "main" {
  # The ID of the portfolio to apply the tag option to
  portfolio_id = aws_servicecatalog_portfolio.main.id
  # The ID of the tag option to apply
  tag_option_id = aws_servicecatalog_tag_option.main.id
}

# Create a Service Catalog Tag Option for a Product
resource "aws_servicecatalog_tag_option_for_product" "main" {
  # The ID of the product to apply the tag option to
  product_id = aws_servicecatalog_product.main.id
  # The ID of the tag option to apply
  tag_option_id = aws_servicecatalog_tag_option.main.id
}

# Create a Service Catalog Constraint
resource "aws_servicecatalog_constraint" "main" {
  # The ID of the portfolio to apply the constraint to
  portfolio_id = aws_servicecatalog_portfolio.main.id
  # The type of constraint (e.g., "ACCOUNT", "TAG", "RESOURCE_LIMIT")
  type = "TAG"
  # The tag key to apply the constraint to
  tag_key = "Environment"
  # The tag values to allow
  tag_values = ["Production", "Development"]
  # Optional: Description of the constraint
  description = "My Constraint Description"
}

# Create a Service Catalog Acceptance Policy
resource "aws_servicecatalog_acceptance_policy" "main" {
  # The ID of the portfolio to apply the acceptance policy to
  portfolio_id = aws_servicecatalog_portfolio.main.id
  # The text of the acceptance policy
  acceptance_policy = "I accept the terms and conditions"
}

# Create a Service Catalog Launch Role Constraint
resource "aws_servicecatalog_launch_role_constraint" "main" {
  # The ID of the portfolio to apply the launch role constraint to
  portfolio_id = aws_servicecatalog_portfolio.main.id
  # The ARN of the launch role to use
  role_arn = "arn:aws:iam::123456789012:role/launch-role"
}

# Create a Service Catalog Tag Option for a Provisioned Product
resource "aws_servicecatalog_tag_option_for_provisioned_product" "main" {
  # The ID of the provisioned product to apply the tag option to
  provisioned_product_id = aws_servicecatalog_provisioned_product.main.id
  # The ID of the tag option to apply
  tag_option_id = aws_servicecatalog_tag_option.main.id
}

# Create a Service Catalog Constraint for a Provisioned Product
resource "aws_servicecatalog_constraint_for_provisioned_product" "main" {
  # The ID of the provisioned product to apply the constraint to
  provisioned_product_id = aws_servicecatalog_provisioned_product.main.id
  # The ID of the constraint to apply
  constraint_id = aws_servicecatalog_constraint.main.id
}

# Create a Service Catalog Tag Option for a Product with a specific value
resource "aws_servicecatalog_tag_option_for_product_with_value" "main" {
  # The ID of the product to apply the tag option to
  product_id = aws_servicecatalog_product.main.id
  # The key for the tag option
  key = "Environment"
  # The value for the tag option
  value = "Production"
}

# Create a Service Catalog Tag Option for a Provisioned Product with a specific value
resource "aws_servicecatalog_tag_option_for_provisioned_product_with_value" "main" {
  # The ID of the provisioned product to apply the tag option to
  provisioned_product_id = aws_servicecatalog_provisioned_product.main.id
  # The key for the tag option
  key = "Environment"
  # The value for the tag option
  value = "Production"
}
  