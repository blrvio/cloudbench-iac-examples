
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a CodeBuild project
resource "aws_codebuild_project" "main" {
  name = "my-codebuild-project"
  # Define the source code repository
  source {
    type     = "GITHUB"
    # If using a GitHub repository
    location = "https://github.com/your-username/your-repository.git"
    # If using an S3 bucket
    # type = "S3"
    # location = "s3://your-bucket/your-directory"
    # If using a CodeCommit repository
    # type = "CODE_COMMIT"
    # location = "your-repo-name"
    # If using a Bitbucket repository
    # type = "BITBUCKET"
    # location = "https://bitbucket.org/your-username/your-repository.git"
  }
  # Define the build environment
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
    # You can define environment variables
    # environment_variables {
    #   name  = "MY_VARIABLE"
    #   value = "my-value"
    # }
  }
  # Define the build spec file
  # The build spec file defines the steps to execute during the build
  # Example:
  # buildspec = <<EOF
  # version: 0.2
  # phases:
  #   pre_build:
  #     commands:
  #       - echo "Pre-build steps"
  #   build:
  #     commands:
  #       - echo "Build steps"
  #   post_build:
  #     commands:
  #       - echo "Post-build steps"
  # EOF
  # If you want to use a custom build spec file, you can specify the path to the file
  # buildspec = "s3://your-bucket/your-buildspec.yml"
}

# Create an IAM role for CodeBuild
resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"
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

# Attach the CodeBuild IAM policy to the CodeBuild role
resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "codebuild-policy"
  role   = aws_iam_role.codebuild_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs",
        "ec2:DescribeVolumes",
        "ec2:DescribeInstances"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:GetRepository",
        "codecommit:GetBranch",
        "codecommit:GetCommit"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:StartBuild",
        "codebuild:StopBuild"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:PassRole"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the IAM role to the CodeBuild project
resource "aws_codebuild_project" "main" {
  ... # other codebuild project properties
  service_role = aws_iam_role.codebuild_role.arn
}

  