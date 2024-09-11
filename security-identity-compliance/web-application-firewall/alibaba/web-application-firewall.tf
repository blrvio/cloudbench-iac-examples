
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "default"
}

# Create a WAF instance
resource "alicloud_waf_instance" "default" {
  name = "my-waf-instance"

  # Optional configurations
  # billing_cycle = "Month"
  # billing_type = "PostPay"
  #  duration = 1
  #  pricing_cycle = "Month"

  #  pay_type = "PayAsYouGo"
}

# Create a WAF domain
resource "alicloud_waf_domain" "default" {
  domain = "example.com"
  instance_id = alicloud_waf_instance.default.id
  # Optional configurations
  #  name = "my-waf-domain"
  #  protocol = "HTTP"
  #  status = "On"
}

# Create a WAF rule
resource "alicloud_waf_rule" "default" {
  instance_id = alicloud_waf_instance.default.id
  name         = "my-waf-rule"
  # Optional configurations
  #  description = "My WAF rule"
  #  rule_type = "Custom"
}

# Create a WAF rule group
resource "alicloud_waf_rule_group" "default" {
  instance_id = alicloud_waf_instance.default.id
  name         = "my-waf-rule-group"
  # Optional configurations
  #  description = "My WAF rule group"
}

# Associate a WAF rule to a rule group
resource "alicloud_waf_rule_group_rule" "default" {
  instance_id = alicloud_waf_instance.default.id
  rule_group_id = alicloud_waf_rule_group.default.id
  rule_id = alicloud_waf_rule.default.id
}

# Create a WAF policy
resource "alicloud_waf_policy" "default" {
  instance_id = alicloud_waf_instance.default.id
  name         = "my-waf-policy"
  # Optional configurations
  #  description = "My WAF policy"
  #  policy_type = "Custom"
}

# Attach a WAF policy to a domain
resource "alicloud_waf_domain_policy" "default" {
  domain_id = alicloud_waf_domain.default.id
  policy_id = alicloud_waf_policy.default.id
}

  