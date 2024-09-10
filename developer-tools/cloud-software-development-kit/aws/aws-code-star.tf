
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a CodeStar Project
resource "aws_codestar_project" "main" {
  name = "my-codestar-project"
  # Optional settings
  source_code_provider {
    # Use GitHub as the source code provider
    type = "GITHUB"
  }
  # Define project settings
  project_settings {
    # Configure the source code repository
    source_code {
      # Use GitHub as the source code provider
      provider = "GITHUB"
    }
    # Configure the AWS CodeBuild project
    build {
      # Set the build settings
      build_type = "DEFAULT"
    }
    # Configure the AWS CodeDeploy deployment settings
    deployment {
      # Set the deployment settings
      deployment_type = "DEFAULT"
    }
  }
}

# Create a CodeStar Project User
resource "aws_codestar_project_user" "main" {
  project_id = aws_codestar_project.main.id
  user_arn   = "arn:aws:iam::<account_id>:user/my-user"
  # Optional settings
  role = "USER"
}

# Create a CodeStar Project Team
resource "aws_codestar_project_team" "main" {
  project_id = aws_codestar_project.main.id
  name       = "my-team"
  # Optional settings
  description = "My team"
  # Add users to the team
  user_arns = ["arn:aws:iam::<account_id>:user/my-user"]
}

  