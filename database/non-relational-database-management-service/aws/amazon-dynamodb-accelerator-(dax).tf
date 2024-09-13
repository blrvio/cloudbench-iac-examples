
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster DAX
resource "aws_dax_cluster" "main" {
  name              = "my-dax-cluster"
  node_type         = "dax.r4.large"
  replication_factor = 3

  cluster_name     = "my-dax-cluster"
  subnet_group_name = "my-dax-subnet-group"

  # Substitua pelos seus valores reais
  iam_role_arn = "arn:aws:iam::123456789012:role/my-dax-role"

  # Define as configurações do cache
  parameter_group_name = "default.dax.parameter.group"
}

# Crie um grupo de sub-redes DAX
resource "aws_dax_subnet_group" "main" {
  name   = "my-dax-subnet-group"
  subnet_ids = ["subnet-xxxxxxxx", "subnet-yyyyyyyy", "subnet-zzzzzzzz"] # Substitua pelos IDs das suas sub-redes
}

# Crie um papel IAM para o DAX
resource "aws_iam_role" "dax" {
  name = "my-dax-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "dax.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Adicione permissões ao papel IAM
resource "aws_iam_role_policy" "dax" {
  name   = "dax-policy"
  role   = aws_iam_role.dax.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:DescribeTable",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

    