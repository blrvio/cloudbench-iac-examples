
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um projeto CodeBuild
resource "aws_codebuild_project" "example" {
  name        = "example"
  source {
    type = "GITHUB"
    # Substitua pelos valores reais
    # location     = "example/repo"
    # auth         = "GITHUB_TOKEN"
    # oauth_token  = "YOUR_GITHUB_TOKEN"
    # buildspec = "buildspec.yml"
    # git_clone_depth = 1
    # report_buildstatus = true
  }
  artifacts {
    type = "NO_ARTIFACTS"
    # Substitua pelos valores reais
    # type      = "CODEPIPELINE"
    # name      = "myArtifacts"
    # location  = "myBucket"
    # path      = "myPath"
    # namespace = "myNamespace"
    # encryption_disabled = false
    # packaging = "NONE"
    # override_artifact_name = false
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    # Substitua pelos valores reais
    # type       = "LINUX_CONTAINER"
    # image      = "aws/codebuild/docker:17.09.0"
    # privileged_mode  = false
    # environment_variables = {
    #   MY_ENV_VAR = "MY_ENV_VAR_VALUE"
    # }
    # certificate = "YOUR_CERTIFICATE_ARN"
    # registry_credential = "YOUR_REGISTRY_CREDENTIAL_ARN"
  }
  # Substitua pelos valores reais
  # service_role = "YOUR_SERVICE_ROLE_ARN"
  # timeout_in_minutes = 60
  # queued_timeout_in_minutes = 15
  # build_timeout_in_minutes = 30
  # encryption_key = "YOUR_ENCRYPTION_KEY_ARN"
  # badge_enabled = true
  # tags = {
  #   Name = "example"
  # }
}

    