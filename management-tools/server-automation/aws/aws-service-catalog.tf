
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um produto do Service Catalog
resource "aws_servicecatalog_product" "my_product" {
  name     = "My Product"
  type     = "AWS_CLOUDFORMATION"
  provisioning_artifact_parameters = {
    # Substitua pelos parâmetros do produto
  }
  owner    = "aws-account-id"
  description = "My Product Description"
}

# Crie um portfólio do Service Catalog
resource "aws_servicecatalog_portfolio" "my_portfolio" {
  name     = "My Portfolio"
  provider = "aws-account-id"
  description = "My Portfolio Description"
}

# Associe o produto ao portfólio
resource "aws_servicecatalog_portfolio_product" "my_portfolio_product" {
  portfolio_id = aws_servicecatalog_portfolio.my_portfolio.id
  product_id  = aws_servicecatalog_product.my_product.id
}

# Crie um provisionamento do produto
resource "aws_servicecatalog_provisioned_product" "my_provisioned_product" {
  product_id  = aws_servicecatalog_product.my_product.id
  provisioning_artifact_id = aws_servicecatalog_product.my_product.provisioning_artifact_id
  path = "path/to/provisioned/product"
}

# Exiba o estado do provisionamento
output "provisioned_product_status" {
  value = aws_servicecatalog_provisioned_product.my_provisioned_product.status
}
    