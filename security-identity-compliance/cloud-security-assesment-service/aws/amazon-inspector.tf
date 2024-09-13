
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um perfil de avaliação do Inspector
resource "aws_inspector_assessment_target" "example" {
  name = "example"
  resource_group_arn = "arn:aws:ec2:us-east-1:123456789012:instance/i-xxxxxxxx"
}

# Crie uma avaliação
resource "aws_inspector_assessment_template" "example" {
  assessment_target_arn = aws_inspector_assessment_target.example.arn
  duration              = 3600
  name                  = "example"
  rules_package_arns     = ["arn:aws:inspector:us-east-1:770794393483:rulespackage/0-AmznManagedRules-Linux-1.0"]
}

# Execute a avaliação
resource "aws_inspector_assessment_run" "example" {
  assessment_template_arn = aws_inspector_assessment_template.example.arn
  name                    = "example"
}

    