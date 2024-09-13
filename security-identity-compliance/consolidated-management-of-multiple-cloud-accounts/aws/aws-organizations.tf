
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma conta de organização
resource "aws_organizations_organization" "main" {
  feature_set = "ALL"
}

# Crie uma conta de membro
resource "aws_organizations_account" "member" {
  email         = "example@example.com" # Substitua pelo email da conta de membro
  name          = "Member Account"
  parent_id     = aws_organizations_organization.main.id
  account_status = "ACTIVE"
}

# Crie uma política de serviço
resource "aws_organizations_policy" "service_control_policy" {
  name          = "service-control-policy"
  description   = "Policy to control AWS services"
  content       = "{\"Statement\":[\"\"\",{\"Effect\":\"Allow\",\"Principal\": {\"AWS\": \"arn:aws:iam::123456789012:root\"},\"Action\": [\"ec2:DescribeInstances\"]},\"\"\"}"
  type          = "SERVICE_CONTROL_POLICY"
}

# Adicione a política de serviço à conta de membro
resource "aws_organizations_policy_attachment" "service_control_policy_attachment" {
  target_id   = aws_organizations_account.member.id
  policy_id   = aws_organizations_policy.service_control_policy.id
}
    