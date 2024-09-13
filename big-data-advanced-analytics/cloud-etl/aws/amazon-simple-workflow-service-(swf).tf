
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um domínio SWF
resource "aws_swf_domain" "example" {
  name = "example-domain"
  description = "Example SWF Domain"
  workflow_execution_retention_period_in_days = 30
}

# Crie um tipo de tarefa SWF
resource "aws_swf_task_list" "example" {
  name = "example-task-list"
}

# Crie um tipo de workflow SWF
resource "aws_swf_workflow_type" "example" {
  name           = "example-workflow-type"
  domain         = aws_swf_domain.example.name
  version        = "1.0"
  default_task_list = aws_swf_task_list.example.name
  child_policy  = "TERMINATE"
}

# Crie um tipo de atividade SWF
resource "aws_swf_activity_type" "example" {
  name           = "example-activity-type"
  domain         = aws_swf_domain.example.name
  version        = "1.0"
  default_task_list = aws_swf_task_list.example.name
}
    