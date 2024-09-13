
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um perfil de revisor do CodeGuru
resource "aws_codeguru_profiler_profiling_group" "default" {
  name = "default"
}

# Crie um perfil de revisor do CodeGuru
resource "aws_codeguru_reviewer_repository_association" "default" {
  repository_id = "arn:aws:codecommit:us-east-1:123456789012:my-repository"
  repository_provider = "CodeCommit"
}

# Crie um perfil de revisor do CodeGuru
resource "aws_codeguru_reviewer_repository_association" "default" {
  repository_id = "https://github.com/my-organization/my-repository"
  repository_provider = "GitHub"
}

# Crie um perfil de revisor do CodeGuru
resource "aws_codeguru_reviewer_repository_association" "default" {
  repository_id = "https://gitlab.com/my-organization/my-repository"
  repository_provider = "GitLab"
}

    