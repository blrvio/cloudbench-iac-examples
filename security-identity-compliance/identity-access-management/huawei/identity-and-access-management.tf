
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um usuário IAM
resource "aws_iam_user" "my_user" {
  name = "my_user"
}

# Crie uma política IAM
resource "aws_iam_policy" "my_policy" {
  name = "my_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource": "arn:aws:s3:::my-bucket/*"
      }
    ]
  })
}

# Adicione a política ao usuário
resource "aws_iam_user_policy" "my_user_policy" {
  user = aws_iam_user.my_user.name
  name = "my_policy"
  policy = aws_iam_policy.my_policy.policy
}
    