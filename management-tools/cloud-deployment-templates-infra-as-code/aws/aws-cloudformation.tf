
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um stack CloudFormation
resource "aws_cloudformation_stack" "my_stack" {
  name = "my-stack"
  template_body = <<EOF
  # ... (Conteúdo do template CloudFormation)
EOF
}

    