
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Define the Data Pipeline
resource "aws_datapipeline" "main" {
  name = "my-data-pipeline"
  # Definition of the pipeline
  pipeline_definition = <<EOF
{
  "name": "My Data Pipeline",
  "description": "This pipeline is a simple example.",
  "schedule": "cron(0 0 * * ? *)",
  "pipelineObjects": [
    {
      "id": "MyFirstObject",
      "name": "My First Object",
      "type": "Schedule",
      "schedule": "cron(0 0 * * ? *)"
    },
    {
      "id": "MySecondObject",
      "name": "My Second Object",
      "type": "ShellCommandActivity",
      "command": "echo 'Hello World!'",
      "dependsOn": [
        "MyFirstObject"
      ]
    }
  ]
}
EOF
}

  