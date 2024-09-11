
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"
  # ... (other configurations)
}

# Create an Alert Rule
resource "alicloud_cms_alert_rule" "main" {
  name = "MyAlertRule"
  # ... (other configurations)
}

# Create an Alert Contact
resource "alicloud_cms_alert_contact" "main" {
  name = "MyAlertContact"
  # ... (other configurations)
}

# Create an Alert Contact Group
resource "alicloud_cms_alert_contact_group" "main" {
  name = "MyAlertContactGroup"
  # ... (other configurations)
}

# Attach Alert Contact Group to Alert Rule
resource "alicloud_cms_alert_rule_contact_group" "main" {
  alert_rule_id = alicloud_cms_alert_rule.main.id
  contact_group_id = alicloud_cms_alert_contact_group.main.id
}
  