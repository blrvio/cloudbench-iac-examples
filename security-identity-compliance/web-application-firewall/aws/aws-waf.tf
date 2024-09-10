
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

# Create a WAF Web ACL
resource "aws_wafv2_web_acl" "main" {
  name = "my-waf-web-acl" # Name of your WAF Web ACL
  scope = "REGIONAL" # Scope of the Web ACL, can be REGIONAL or CLOUDFRONT
  # Define the rules to apply to the Web ACL
  default_action {
    allow {
    }
  }
  rules {
    name = "allow-https-traffic" # Name of the rule
    priority = 1 # Priority of the rule
    # Define the conditions for the rule
    statement {
      # Allow traffic from HTTPS connections
      # This condition matches the connection's protocol
      # https://docs.aws.amazon.com/waf/latest/APIReference/API_Statement.html#WAF-Type-Statement-FieldToMatch
      # https://docs.aws.amazon.com/waf/latest/APIReference/API_FieldToMatch.html#WAF-Type-FieldToMatch-MatchFieldType
      # https://docs.aws.amazon.com/waf/latest/APIReference/API_FieldToMatch.html#WAF-Type-FieldToMatch-MatchTokenType
      # https://docs.aws.amazon.com/waf/latest/APIReference/API_MatchStatement.html#WAF-Type-MatchStatement-FieldToMatch
      # https://docs.aws.amazon.com/waf/latest/APIReference/API_MatchStatement.html#WAF-Type-MatchStatement-TextTransformation
      match_statement {
        # The match statement can have several field to match, for the full list see the AWS API
        # https://docs.aws.amazon.com/waf/latest/APIReference/API_MatchStatement.html
        field_to_match {
          type = "HEADER"
          data = "X-Forwarded-Proto"
        }
        text_transformation {
          priority = 0
          type = "NONE"
        }
        # Set the rule action, this action allows the request
        # https://docs.aws.amazon.com/waf/latest/APIReference/API_MatchStatement.html#WAF-Type-MatchStatement-MatchResult
        match_result {
          match_result = "ALLOW"
        }
      }
    }
  }
}

# Create a WAF Rule Group
resource "aws_wafv2_rule_group" "main" {
  name = "my-waf-rule-group" # Name of your WAF Rule Group
  scope = "REGIONAL" # Scope of the Rule Group, can be REGIONAL or CLOUDFRONT
  # Define the rules to apply to the Rule Group
  rules {
    name = "allow-https-traffic" # Name of the rule
    priority = 1 # Priority of the rule
    # Define the conditions for the rule
    statement {
      # Allow traffic from HTTPS connections
      # This condition matches the connection's protocol
      # https://docs.aws.amazon.com/waf/latest/APIReference/API_Statement.html#WAF-Type-Statement-FieldToMatch
      # https://docs.aws.amazon.com/waf/latest/APIReference/API_FieldToMatch.html#WAF-Type-FieldToMatch-MatchFieldType
      # https://docs.aws.amazon.com/waf/latest/APIReference/API_FieldToMatch.html#WAF-Type-FieldToMatch-MatchTokenType
      # https://docs.aws.amazon.com/waf/latest/APIReference/API_MatchStatement.html#WAF-Type-MatchStatement-FieldToMatch
      # https://docs.aws.amazon.com/waf/latest/APIReference/API_MatchStatement.html#WAF-Type-MatchStatement-TextTransformation
      match_statement {
        # The match statement can have several field to match, for the full list see the AWS API
        # https://docs.aws.amazon.com/waf/latest/APIReference/API_MatchStatement.html
        field_to_match {
          type = "HEADER"
          data = "X-Forwarded-Proto"
        }
        text_transformation {
          priority = 0
          type = "NONE"
        }
        # Set the rule action, this action allows the request
        # https://docs.aws.amazon.com/waf/latest/APIReference/API_MatchStatement.html#WAF-Type-MatchStatement-MatchResult
        match_result {
          match_result = "ALLOW"
        }
      }
    }
  }
}

# Create a WAF Web ACL Association
resource "aws_wafv2_web_acl_association" "main" {
  web_acl_arn = aws_wafv2_web_acl.main.arn # ARN of the Web ACL
  resource_arn = "arn:aws:cloudfront::123456789012:distribution/E1234567890ABC123" # ARN of the resource to associate the Web ACL with
}

  