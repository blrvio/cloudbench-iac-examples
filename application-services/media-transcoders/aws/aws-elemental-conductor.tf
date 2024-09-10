
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Elemental Conductor Workflow
resource "aws_elemental_conductor_workflow" "main" {
  name = "my-workflow"
  description = "My sample workflow"
  # Defines the workflow execution role, which will have permissions to access other AWS services used by the workflow.
  execution_role_arn = aws_iam_role.execution_role.arn
  # Defines the workflow's scheduling configuration, including the frequency and time zone.
  schedule_config {
    schedule_expression = "rate(1 hour)" # Specifies a cron expression that determines when the workflow runs.
    timezone = "America/Los_Angeles" # Sets the time zone for the workflow execution.
  }
}

# Create a IAM Role for the workflow execution
resource "aws_iam_role" "execution_role" {
  name = "elemental-conductor-execution-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "elementalconductor.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Attach the necessary IAM policies to the execution role
resource "aws_iam_role_policy_attachment" "execution_policy" {
  role = aws_iam_role.execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Create a workflow template
resource "aws_elemental_conductor_workflow_template" "main" {
  name = "my-template"
  description = "My sample workflow template"
  # Defines the workflow template's execution role, which will have permissions to access other AWS services used by the workflow template.
  execution_role_arn = aws_iam_role.execution_role.arn
  # Defines the workflow template's scheduling configuration, including the frequency and time zone.
  schedule_config {
    schedule_expression = "rate(1 hour)" # Specifies a cron expression that determines when the workflow runs.
    timezone = "America/Los_Angeles" # Sets the time zone for the workflow execution.
  }
  # Defines the workflow template's properties, including its input and output parameters.
  properties {
    # Specifies the type of the input parameters for the workflow template.
    input_parameters {
      # Specifies the type of the input parameter.
      type = "string"
      # Defines the input parameter's name.
      name = "input-param"
    }
    # Specifies the type of the output parameters for the workflow template.
    output_parameters {
      # Specifies the type of the output parameter.
      type = "string"
      # Defines the output parameter's name.
      name = "output-param"
    }
  }
}

# Create a workflow template version
resource "aws_elemental_conductor_workflow_template_version" "main" {
  name = "my-template-version"
  description = "My sample workflow template version"
  template_id = aws_elemental_conductor_workflow_template.main.id
  # Defines the workflow template version's properties, including its input and output parameters.
  properties {
    # Defines the workflow template version's steps, which are the individual tasks that make up the workflow.
    steps {
      # Defines the step's name.
      name = "step-1"
      # Defines the step's action, which is the specific task that the step performs.
      action = "s3:GetObject"
      # Defines the step's input parameters, which are the values that the step uses to perform its task.
      input_parameters {
        # Defines the input parameter's name.
        name = "bucket"
        # Defines the input parameter's value.
        value = "my-bucket"
      }
      # Defines the step's output parameters, which are the values that the step returns after it completes.
      output_parameters {
        # Defines the output parameter's name.
        name = "key"
        # Defines the output parameter's value.
        value = "my-key"
      }
    }
  }
}

# Create a workflow execution
resource "aws_elemental_conductor_workflow_execution" "main" {
  workflow_id = aws_elemental_conductor_workflow.main.id
  # Defines the workflow execution's input parameters, which are the values that the workflow uses to start running.
  input_parameters {
    # Defines the input parameter's name.
    name = "input-param"
    # Defines the input parameter's value.
    value = "my-input-value"
  }
}

# Create a workflow execution role
resource "aws_iam_role" "execution_role" {
  name = "elemental-conductor-execution-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "elementalconductor.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Attach the necessary IAM policies to the execution role
resource "aws_iam_role_policy_attachment" "execution_policy" {
  role = aws_iam_role.execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Create a workflow template
resource "aws_elemental_conductor_workflow_template" "main" {
  name = "my-template"
  description = "My sample workflow template"
  # Defines the workflow template's execution role, which will have permissions to access other AWS services used by the workflow template.
  execution_role_arn = aws_iam_role.execution_role.arn
  # Defines the workflow template's scheduling configuration, including the frequency and time zone.
  schedule_config {
    schedule_expression = "rate(1 hour)" # Specifies a cron expression that determines when the workflow runs.
    timezone = "America/Los_Angeles" # Sets the time zone for the workflow execution.
  }
  # Defines the workflow template's properties, including its input and output parameters.
  properties {
    # Specifies the type of the input parameters for the workflow template.
    input_parameters {
      # Specifies the type of the input parameter.
      type = "string"
      # Defines the input parameter's name.
      name = "input-param"
    }
    # Specifies the type of the output parameters for the workflow template.
    output_parameters {
      # Specifies the type of the output parameter.
      type = "string"
      # Defines the output parameter's name.
      name = "output-param"
    }
  }
}

# Create a workflow template version
resource "aws_elemental_conductor_workflow_template_version" "main" {
  name = "my-template-version"
  description = "My sample workflow template version"
  template_id = aws_elemental_conductor_workflow_template.main.id
  # Defines the workflow template version's properties, including its input and output parameters.
  properties {
    # Defines the workflow template version's steps, which are the individual tasks that make up the workflow.
    steps {
      # Defines the step's name.
      name = "step-1"
      # Defines the step's action, which is the specific task that the step performs.
      action = "s3:GetObject"
      # Defines the step's input parameters, which are the values that the step uses to perform its task.
      input_parameters {
        # Defines the input parameter's name.
        name = "bucket"
        # Defines the input parameter's value.
        value = "my-bucket"
      }
      # Defines the step's output parameters, which are the values that the step returns after it completes.
      output_parameters {
        # Defines the output parameter's name.
        name = "key"
        # Defines the output parameter's value.
        value = "my-key"
      }
    }
  }
}

# Create a workflow execution
resource "aws_elemental_conductor_workflow_execution" "main" {
  workflow_id = aws_elemental_conductor_workflow.main.id
  # Defines the workflow execution's input parameters, which are the values that the workflow uses to start running.
  input_parameters {
    # Defines the input parameter's name.
    name = "input-param"
    # Defines the input parameter's value.
    value = "my-input-value"
  }
}
  