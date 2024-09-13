
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma associação de licença
resource "aws_license_manager_association" "example" {
  license_arn = "arn:aws:license-manager:us-east-1:123456789012:license:license-123456789012"
  resource_arn = "arn:aws:ec2:us-east-1:123456789012:instance/i-123456789012"
}

# Crie um conjunto de licenças
resource "aws_license_manager_license_configuration" "example" {
  name = "Example License Configuration"
  license_counting_type = "COUNT_ONLY"
  description = "Example license configuration"
  license_rules = <<EOF
  {  "name": "Allow Linux",  "match": {  "resourceType": ["EC2_INSTANCE"],  "osType": ["Linux"]  },  "requirements": []
}
EOF
}

# Importe uma licença do arquivo local
resource "aws_license_manager_license" "example" {
  license_name     = "example-license"
  license_key      = "license-key"
  beneficiary       = "account-id"
  license_type      = "bring-your-own_license"
  license_content   = filebase64("path/to/license.txt")
  disassociate_when_not_found = true
}

    