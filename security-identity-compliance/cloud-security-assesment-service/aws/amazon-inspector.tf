
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Inspector assessment target
resource "aws_inspector_assessment_target" "main" {
  name = "my-assessment-target"
  # Define the resource groups to be assessed
  resource_group_arn = "arn:aws:ec2:us-east-1:123456789012:instance/i-0123456789abcdef0"
}

# Create an Inspector assessment template
resource "aws_inspector_assessment_template" "main" {
  assessment_target_arn = aws_inspector_assessment_target.main.arn
  name                     = "my-assessment-template"
  # Define the assessment rules to be used
  rules_package_arns = ["arn:aws:inspector:us-east-1:770794393852:rulespackage/0-AmznManagedRules-EC2_Linux"
]
}

# Run an Inspector assessment
resource "aws_inspector_assessment" "main" {
  assessment_template_arn = aws_inspector_assessment_template.main.arn
  name                      = "my-assessment"
  # Optional configuration for assessment duration
  duration_in_seconds       = 3600 # 1 hour
}

  