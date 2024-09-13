
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um usuário IAM
resource "aws_iam_user" "example" {
  name = "example-user"
}

# Crie uma política IAM
resource "aws_iam_policy" "example" {
  name = "example-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource": "arn:aws:s3:::example-bucket/*"
      }
    ]
  })
}

# Adicione a política ao usuário IAM
resource "aws_iam_user_policy" "example" {
  user  = aws_iam_user.example.name
  policy = aws_iam_policy.example.id
}

# Crie um papel IAM
resource "aws_iam_role" "example" {
  name = "example-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Adicione a política ao papel IAM
resource "aws_iam_role_policy_attachment" "example" {
  role   = aws_iam_role.example.name
  policy = aws_iam_policy.example.id
}
    