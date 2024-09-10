
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a CodePipeline
resource "aws_codepipeline" "example" {
  name     = "my-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn
  artifact_store {
    location = aws_s3_bucket.codepipeline_artifact_store.bucket
    type     = "S3"
  }
  stage {
    name = "Source"
    action {
      name     = "SourceAction"
      category = "Source"
      provider = "GitHub"
      # Replace with your actual Github repository
      # and configure authentication according to your needs
      configuration = {
        Owner  = "your-github-owner"
        Repo   = "your-github-repo"
        Branch = "main"
        # Use the GitHub Access Token
        OAuthToken = "your-github-token"
      }
    }
  }
  stage {
    name = "Build"
    action {
      name     = "BuildAction"
      category = "Build"
      provider = "CodeBuild"
      configuration = {
        # Replace with the name of the CodeBuild project
        ProjectName = "my-codebuild-project"
      }
    }
  }
  stage {
    name = "Deploy"
    action {
      name     = "DeployAction"
      category = "Deploy"
      provider = "ECS"
      configuration = {
        # Replace with the name of the ECS cluster
        ClusterName = "my-ecs-cluster"
        # Replace with the name of the ECS service
        ServiceName = "my-ecs-service"
      }
    }
  }
}

# Create an IAM role for CodePipeline
resource "aws_iam_role" "codepipeline_role" {
  name               = "codepipeline-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach permissions to the CodePipeline role
resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline-policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild",
        "codebuild:StopBuild",
        "codepipeline:CreatePipeline",
        "codepipeline:DeletePipeline",
        "codepipeline:GetPipeline",
        "codepipeline:GetPipelineExecution",
        "codepipeline:ListPipelines",
        "codepipeline:PollForJobs",
        "codepipeline:PutJobSuccessResult",
        "codepipeline:PutJobFailureResult",
        "codepipeline:UpdatePipeline",
        "codepipeline:StartPipelineExecution",
        "s3:GetObject",
        "s3:PutObject",
        "s3:GetObjectVersion",
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeleteCluster",
        "ecs:DescribeClusters",
        "ecs:ListClusters",
        "ecs:UpdateCluster",
        "ecs:CreateService",
        "ecs:DeleteService",
        "ecs:DescribeServices",
        "ecs:ListServices",
        "ecs:UpdateService",
        "ecs:RunTask",
        "ecs:StartTask",
        "ecs:StopTask",
        "ecs:DescribeTasks",
        "ecs:ListTasks",
        "ecs:DescribeTaskDefinition",
        "ecs:ListTaskDefinitions",
        "ecs:RegisterTaskDefinition",
        "ecs:DeregisterTaskDefinition"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:PassRole"
      ],
      "Resource": "arn:aws:iam::123456789012:role/codepipeline-role"
    }
  ]
}
EOF
}

# Create an S3 bucket for storing artifacts
resource "aws_s3_bucket" "codepipeline_artifact_store" {
  bucket = "my-codepipeline-artifacts"
  acl    = "private"
}

# Create a CodeBuild project
resource "aws_codebuild_project" "example" {
  name        = "my-codebuild-project"
  description = "A CodeBuild project for my CodePipeline"
  source {
    type = "GITHUB"
    # Replace with your actual Github repository
    # and configure authentication according to your needs
    location = "your-github-owner/your-github-repo"
    # Use the GitHub Access Token
    buildspec       = <<EOF
version: 0.2
phases:
  install:
    commands:
      - echo Installing dependencies
      - npm install
  build:
    commands:
      - echo Building the application
      - npm run build
  post_build:
    commands:
      - echo Pushing the artifacts
      - aws s3 cp build output.zip s3://my-codepipeline-artifacts/output.zip
EOF
    git_clone_depth = 1
    # Configure the authentication
    # You can configure authentication using an OAuth Token
    # or an SSH key
    # For OAuth Token:
    # authentication = "OAUTH"
    # oauth_token = "your-github-token"
    # For SSH key:
    # authentication = "SSH"
    # ssh_key_contents = "your-ssh-key"
  }
  # Replace with the name of the AWS CodeBuild Service Role
  # that grants access to resources that are required for builds
  service_role = aws_iam_role.codebuild_service_role.arn
  artifacts {
    type = "S3"
    # Replace with the name of the S3 bucket
    location = "my-codepipeline-artifacts"
    path     = "output.zip"
  }
  environment {
    type         = "LINUX_CONTAINER"
    image        = "aws/codebuild/standard:5.0"
    compute_type = "BUILD_GENERAL1_SMALL"
  }
}

# Create a IAM Role for CodeBuild
resource "aws_iam_role" "codebuild_service_role" {
  name               = "codebuild-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach permissions to the CodeBuild role
resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "codebuild-policy"
  role   = aws_iam_role.codebuild_service_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetAuthorizationToken",
        "ecr:GetRegistryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:PutImage",
        "ecr:BatchDeleteImage"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:GetObjectVersion",
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild",
        "codebuild:StopBuild"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:PassRole"
      ],
      "Resource": "arn:aws:iam::123456789012:role/codebuild-service-role"
    }
  ]
}
EOF
}

# Create a ECS cluster
resource "aws_ecs_cluster" "example" {
  name = "my-ecs-cluster"
}

# Create a ECS service
resource "aws_ecs_service" "example" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.example.arn
  desired_count   = 1
}

# Create a ECS task definition
resource "aws_ecs_task_definition" "example" {
  family                = "my-ecs-task-definition"
  container_definitions = <<EOF
[ 
  {
    "name": "my-ecs-task",
    "image": "your-docker-image",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "MY_VAR",
        "value": "your-value"
      }
    ]
  }
]
EOF
  network_mode          = "bridge"
}

  