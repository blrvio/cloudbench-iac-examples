
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Web ACL
resource "aws_wafv2_web_acl" "example" {
  name     = "example-waf-web-acl"
  scope    = "REGIONAL"
  default_action {
    allow {}
  }
  # ... regras adicionais
}

# Crie um conjunto de regras de WAF
resource "aws_wafv2_rule_group" "example" {
  name   = "example-waf-rule-group"
  scope  = "REGIONAL"
  # ... regras adicionais
}

# Adicione um conjunto de regras ao Web ACL
resource "aws_wafv2_web_acl_rule_statement" "example" {
  web_acl_id     = aws_wafv2_web_acl.example.id
  name            = "example-rule-statement"
  priority        = 1
  rule_group_reference_statement {
    arn = aws_wafv2_rule_group.example.arn
  }
}

# ... configurações adicionais de WAF

    