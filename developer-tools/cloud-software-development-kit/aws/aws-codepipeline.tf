
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um pipeline do CodePipeline
resource "aws_codepipeline" "example" {
  name = "example-pipeline"
  role_arn = "arn:aws:iam::123456789012:role/codepipeline-role"

  artifact_store {
    location = "s3://example-bucket"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name      = "Source"
      category  = "Source"
      owner     = "AWS"
      provider  = "CodeCommit"
      input_artifact_name = "source_artifact"
      configuration = {
        RepositoryName = "example-repo"
        BranchName     = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name      = "Build"
      category  = "Build"
      owner     = "AWS"
      provider  = "CodeBuild"
      input_artifact_name  = "source_artifact"
      output_artifact_name = "build_artifact"
      configuration = {
        ProjectName = "example-build-project"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name      = "Deploy"
      category  = "Deploy"
      owner     = "AWS"
      provider  = "ECS"
      input_artifact_name  = "build_artifact"
      output_artifact_name = "deploy_artifact"
      configuration = {
        ServiceNamespace = "aws.codepipeline"
        ClusterName     = "example-ecs-cluster"
        ServiceName     = "example-ecs-service"
      }
    }
  }
}
    