
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um usuário IAM
resource "aws_iam_user" "example" {
  name = "example_user"
}

# Crie uma política IAM
resource "aws_iam_policy" "example" {
  name = "example_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": [
          "arn:aws:s3:::example-bucket"
        ]
      }
    ]
  })
}

# Adicione a política ao usuário IAM
resource "aws_iam_user_policy" "example" {
  user = aws_iam_user.example.name
  name = "example_policy"
  policy = aws_iam_policy.example.policy
}
    