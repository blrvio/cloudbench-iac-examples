
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon A2I HumanLoop
resource "aws_a2i_human_loop" "main" {
  flow_definition_arn = aws_a2i_flow_definition.main.arn
  human_task_config {
    task_title = "Document Review"
    task_description = "Please review the document and provide feedback."
    # Define the input data for the human review task
    input_content {
      # Use the data from the S3 bucket
      s3_content {
        bucket_name = "my-bucket-name"
        object_key  = "my-object-key"
      }
    }
    # Define the output data for the human review task
    output_content {
      # Store the output data in the S3 bucket
      s3_content {
        bucket_name = "my-output-bucket-name"
        object_key  = "my-output-object-key"
      }
    }
  }
  human_task_ui {
    # Define the user interface for the human review task
    ui_config {
      # Use the default UI
      human_task_ui_template_arn = "arn:aws:a2i:us-east-1:123456789012:ui-template/default"
    }
  }
  task_timeout_in_seconds = 3600 # Timeout for the human review task in seconds
  # Define the task type for the human review task
  task_type {
    human_task_type = "TextClassification"
  }
}

# Create an Amazon A2I FlowDefinition
resource "aws_a2i_flow_definition" "main" {
  name = "my-flow-definition"
  # Define the flow definition for the human review task
  flow_definition {
    # Define the human review task
    human_loop {
      # Configure the human review task
      human_loop_config {
        # Define the task to be performed by the human
        human_task {
          task_title = "Document Review"
          # Define the input data for the human task
          input_content {
            # Use the data from the S3 bucket
            s3_content {
              bucket_name = "my-bucket-name"
              object_key  = "my-object-key"
            }
          }
          # Define the output data for the human task
          output_content {
            # Store the output data in the S3 bucket
            s3_content {
              bucket_name = "my-output-bucket-name"
              object_key  = "my-output-object-key"
            }
          }
        }
      }
    }
    # Define the model to be used for the human review task
    human_loop_config {
      model {
        # Use the default model
        model_arn = "arn:aws:a2i:us-east-1:123456789012:model/default"
      }
    }
    # Define the data source for the human review task
    human_loop_config {
      data_source {
        # Use the data from the S3 bucket
        s3_data_source {
          bucket_name = "my-bucket-name"
          object_key  = "my-object-key"
        }
      }
    }
  }
}

  