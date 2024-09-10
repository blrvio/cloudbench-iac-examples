
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Systems Manager Document
resource "aws_ssm_document" "main" {
  content = <<EOF
  # Define your SSM document content in YAML format
  # Here is a simple example of a document that will run a command on an instance
  schemaVersion: "2.2"
  description: "Run a simple command on an instance"
  parameters:
    command: 
      type: "String"
      description: "The command to run on the instance"
  runtimeConfig:
    aws:runShellScript:
      # Specify the script to run
      script: "{{ command }}"
EOF
  name    = "my-ssm-document" # Name of the SSM document
  # Specify tags for your SSM document
  tags = {
    Name = "My SSM Document"
  }
}

# Create an SSM Parameter
resource "aws_ssm_parameter" "main" {
  name  = "my-ssm-parameter"   # Name of the parameter
  type  = "String"             # Type of parameter
  value = "my-parameter-value" # Value of the parameter
  # Specify tags for your SSM parameter
  tags = {
    Name = "My SSM Parameter"
  }
}

# Create a State Machine
resource "aws_states_machine" "main" {
  name       = "my-state-machine"
  definition = <<EOF
  # Define your state machine definition in JSON format
  # Here is a simple example of a state machine that runs a command on an instance
  {
    "StartAt": "RunCommand",
    "States": {
      "RunCommand": {
        "Type": "Task",
        "Resource": "arn:aws:states:::aws-sdk:ec2:RunCommand",
        "Parameters": {
          "ServiceToken": "arn:aws:ssm:us-east-1:123456789012:document/AWS-RunShellScript",
          "InstanceIds": ["i-1234567890abcdef0"],
          "Commands": ["echo 'Hello from AWS Systems Manager'"]
        },
        "Next": "End"
      },
      "End": {
        "Type": "Succeed"
      }
    }
  }
EOF
  # Specify tags for your state machine
  tags = {
    Name = "My State Machine"
  }
}

  