
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a CodeGuru Profiler profiling group
resource "aws_codeguruprofiler_profiling_group" "main" {
  name = "my-profiler-group" # Name of the profiling group
  # Define the profiling group's configuration
  profiling_group_config {
    agent_permissions = "AGENT_PERMISSIONS_READ_ONLY"
    compute_platform  = "EC2" # Compute platform to profile
  }
  # Optional parameters
  tags = {
    Name = "My CodeGuru Profiler Group"
  }
}

# Create a CodeGuru Reviewer repository
resource "aws_codeguru_reviewer_repository" "main" {
  name            = "my-reviewer-repo" # Name of the repository
  repository_type = "CODE_COMMIT"      # Type of the repository
  # Define the CodeCommit repository configuration
  code_commit {
    repository_name = "my-codecommit-repo"
    # Define the CodeCommit repository's AWS Account ID
    account_id = "123456789012"
  }
}

# Create a CodeGuru Reviewer code review
resource "aws_codeguru_reviewer_code_review" "main" {
  name = "my-code-review" # Name of the code review
  # Define the Code Review configuration
  code_review_config {
    repository_id = aws_codeguru_reviewer_repository.main.id
    # Define the code review's branch
    branch = "main"
    # Define the code review's commit ID
    commit_id = "12345678901234567890123456789012"
    # Define the code review's code review type
    code_review_type = "PULL_REQUEST"
  }
}

  