
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um usuário IAM
resource "aws_iam_user" "example" {
  name = "example-user"
}

# Crie uma política IAM
resource "aws_iam_policy" "admin_policy" {
  name = "admin_policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
POLICY
}

# Anexe a política ao usuário
resource "aws_iam_user_policy" "admin_policy_attachment" {
  user = aws_iam_user.example.name
  policy_arn = aws_iam_policy.admin_policy.arn
}
    