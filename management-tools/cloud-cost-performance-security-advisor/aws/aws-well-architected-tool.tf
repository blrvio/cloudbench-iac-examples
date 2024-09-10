
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Well-Architected Tool workload
resource "aws_well_architected_workload" "main" {
  account_id        = "123456789012"                                                                                       # Replace with your AWS account ID
  name              = "my-workload"                                                                                        # Replace with a descriptive workload name
  pillar_priorities = ["operational_excellence", "security", "reliability", "performance_efficiency", "cost_optimization"] # Prioritize the pillars based on your needs
  # Optional: Add tags to the workload
  tags = {
    Name = "My Well-Architected Tool Workload"
  }
}

# Create a lens for the workload
resource "aws_well_architected_lens_review" "main" {
  workload_id = aws_well_architected_workload.main.id
  lens_name   = "well-architected-lens-v2.0" # Use the AWS Well-Architected Framework version 2.0 lens
  # You can also add custom lenses
  # lens_name = "my-custom-lens"
}

# Review the workload
resource "aws_well_architected_review" "main" {
  workload_id = aws_well_architected_workload.main.id
}

# Add questions to the workload
resource "aws_well_architected_question" "main" {
  workload_id = aws_well_architected_workload.main.id
  lens_name   = "well-architected-lens-v2.0"
  # Choose a relevant question from the lens
  question_id = "security_q1"
  # Provide answers to the questions
  answers = {
    "security_q1_a1" = "yes"
    "security_q1_a2" = "no"
  }
}

# You can add more questions and answers to the workload based on your specific needs.
  