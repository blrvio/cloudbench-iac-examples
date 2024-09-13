
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um repositório CodeCommit
resource "aws_codecommit_repository" "example" {
  repository_name = "my-repo" # Substitua pelo nome do repositório desejado
}

# Crie um usuário IAM com acesso ao repositório
resource "aws_iam_user" "example" {
  name = "codecommit-user" # Substitua pelo nome do usuário desejado
}

# Crie uma chave de acesso para o usuário
resource "aws_iam_access_key" "example" {
  user = aws_iam_user.example.name
}

# Adicione a política IAM para acesso ao repositório CodeCommit
resource "aws_iam_policy" "example" {
  name = "codecommit-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "codecommit:GitPull",
          "codecommit:GitPush"
        ],
        "Resource": [
          "arn:aws:codecommit:us-east-1:123456789012:my-repo"
        ]
      }
    ]
  })
}

# Adicione a política ao usuário
resource "aws_iam_user_policy" "example" {
  user = aws_iam_user.example.name
  policy_arn = aws_iam_policy.example.arn
}
    