
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create a Web Application Firewall (WAF) instance
resource "huaweicloud_waf_instance" "main" {
  name = "my-waf-instance" # Name of your WAF instance
  # Optional settings
  description = "My WAF instance"
  # Select the desired protection mode
  protection_mode = "normal"
  # Set the desired instance status
  status = "active"
}

# Create a WAF rule
resource "huaweicloud_waf_rule" "main" {
  instance_id = huaweicloud_waf_instance.main.id # ID of your WAF instance
  name = "my-waf-rule" # Name of your WAF rule
  # Optional settings
  description = "My WAF rule"
  # Define the WAF rule's content
  rule_content = {
    # Define the WAF rule's actions
    actions = [
      {
        # Choose the desired action
        action_type = "block"
      }
    ]
    # Define the WAF rule's conditions
    conditions = [
      {
        # Choose the desired condition type
        condition_type = "sql_injection"
        # Define the condition's parameters
        condition_params = {
          # Define the condition's match mode
          match_mode = "exact"
        }
      }
    ]
  }
}

# Create a WAF rule group
resource "huaweicloud_waf_rule_group" "main" {
  instance_id = huaweicloud_waf_instance.main.id # ID of your WAF instance
  name = "my-waf-rule-group" # Name of your WAF rule group
  # Optional settings
  description = "My WAF rule group"
  # Define the WAF rule group's content
  rule_group_content = {
    # Define the WAF rule group's rules
    rules = [
      {
        # Choose the desired WAF rule
        rule_id = huaweicloud_waf_rule.main.id
      }
    ]
  }
}

  