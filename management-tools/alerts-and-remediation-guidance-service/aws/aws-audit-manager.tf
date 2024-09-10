
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Audit Manager Assessment
resource "aws_auditmanager_assessment" "main" {
  name        = "MyAuditManagerAssessment"
  description = "Assessment for compliance with PCI DSS"
  framework   = "PCI DSS"
  assessment_scope {
    # Include all AWS accounts
    all_aws_accounts = true
  }
}

# Create an Audit Manager Control
resource "aws_auditmanager_control" "main" {
  assessment_id = aws_auditmanager_assessment.main.id
  name          = "PCI DSS Control 1"
  description   = "Control 1 description"
  # Define the control type (manual or automated)
  control_type = "manual"
  # Add control steps
  control_steps = ["Step 1", "Step 2"]
  # Define the control testing information
  evidence_requirements = ["Evidence 1", "Evidence 2"]
}

# Create an Audit Manager Assessment Framework
resource "aws_auditmanager_assessment_framework" "main" {
  name      = "MyFramework"
  framework = "PCI DSS"
  # Add frameworks to the control set
  control_sets = ["Control Set 1", "Control Set 2"]
}

# Create an Audit Manager Control Set
resource "aws_auditmanager_control_set" "main" {
  assessment_framework_id = aws_auditmanager_assessment_framework.main.id
  name                    = "Control Set 1"
  # Add controls to the control set
  controls = [aws_auditmanager_control.main.id]
}
  