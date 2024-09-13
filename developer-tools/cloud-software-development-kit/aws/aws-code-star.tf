
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um projeto CodeStar
resource "aws_codestar_project" "my_project" {
  name = "my-project"
  source_code {
    type       = "GitHub"
    connection_arn = "arn:aws:codestar-connections:us-east-1:xxxxxxxxxxxx:connection:xxxxxxxxxxxx"
    repository_url = "https://github.com/example/my-repo"
    branch        = "master"
  }
  template_name = "aws-sam-quickstart"
  id           = "xxxxxxxxxxxx"
}

# Crie um pipeline CodePipeline
resource "aws_codepipeline" "my_pipeline" {
  name = "my-pipeline"
  role_arn = "arn:aws:iam::xxxxxxxxxxxx:role/CodeStar-xxxxxxxxxxxx"
  artifact_store {
    type = "S3"
    location = "codestar-artifacts-xxxxxxxxxxxx"
  }
  stages {
    name = "Source"
    actions {
      name = "Source"
      action_type {
        owner = "AWS"
        category = "Source"
        version = "1"
        provider = "GitHub"
      }
      configuration {
        Owner = "GitHub"
        Repo  = "my-repo"
        Branch = "master"
      }
    }
  }
  stages {
    name = "Build"
    actions {
      name = "Build"
      action_type {
        owner = "AWS"
        category = "Build"
        version = "1"
        provider = "CodeBuild"
      }
      configuration {
        ProjectName = "my-build-project"
      }
    }
  }
  stages {
    name = "Deploy"
    actions {
      name = "Deploy"
      action_type {
        owner = "AWS"
        category = "Deploy"
        version = "1"
        provider = "CloudFormation"
      }
      configuration {
        StackName = "my-stack"
        TemplatePath = "s3://my-bucket/my-template.yaml"
        Capabilities = ["CAPABILITY_IAM"]
      }
    }
  }
}
    