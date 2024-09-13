
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um fluxo de trabalho A2I
resource "aws_a2i_workflow" "example" {
  name = "example-workflow"
  human_review_config {
    human_review_type = "private"
  }

  output_config {
    s3_uri = "s3://bucket-name/output/path"
  }

  task_config {
    task_type = "image-classification"
  }
}

# Crie um trabalho de A2I
resource "aws_a2i_workteam" "example" {
  name = "example-workteam"
  workforce_type = "private"

  workteam_config {
    workforce_type = "private"
    workforce_type_config {
      private {
        team_arn = "arn:aws:workspaces:us-east-1:123456789012:workspace:example-workspace"
      }
    }
  }
}

# Crie um trabalho de A2I
resource "aws_a2i_labeling_job" "example" {
  name = "example-labeling-job"

  human_task_config {
    task_type        = "image-classification"
    workteam_arn     = aws_a2i_workteam.example.arn
    human_task_input {
      data_source {
        s3_data_source {
          manifest_file_uri = "s3://bucket-name/manifest.json"
        }
      }
    }
  }
  output_config {
    s3_uri = "s3://bucket-name/output/path"
  }
}

    