
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

# Create a WorkMail Organization
resource "aws_workmail_organization" "main" {
  name = "my-workmail-organization" # Name for your WorkMail organization
  # Enable or disable the Amazon WorkMail service
  # Default is "ENABLED"
  # Optional, supported values: "ENABLED", "DISABLED"
  # enable_workmail = "ENABLED"
  # Enable or disable the Amazon WorkMail service
  # Default is "ENABLED"
  # Optional, supported values: "ENABLED", "DISABLED"
  # enable_workmail_service = "ENABLED"
  # Optionally configure the organization's domain.
  # Required for using a custom domain.
  # This is optional and depends on your configuration.
  # organization_domain = "my-organization-domain.com"
  # Optionally configure the organization's alias domain.
  # Optional, supported values: "your-alias-domain.com"
  # organization_alias_domain = "your-alias-domain.com"
  # Optionally enable Amazon WorkMail's  "Use Existing AD Domain" feature.
  # This feature enables you to integrate your existing Active Directory domain with Amazon WorkMail.
  # Optionally configure Active Directory Connector settings when using "Use Existing AD Domain
  # feature.
  # Required for using the "Use Existing AD Domain" feature.
  # active_directory_connector_settings {
  #   # Configure the path to your existing Active Directory Domain.
  #   ad_domain_name = "your-active-directory-domain.com"
  #   # Configure the Active Directory Connector credentials
  #   ad_domain_password = "your-active-directory-password"
  #   # Configure the Active Directory Connector credentials
  #   ad_domain_username = "your-active-directory-username"
  #   # Configure the Active Directory Connector endpoint
  #   ad_domain_endpoint = "your-active-directory-endpoint"
  #   # Configure the Active Directory Connector port
  #   ad_domain_port = 389
  #   # Configure the Active Directory Connector secure port
  #   ad_domain_secure_port = 636
  #   # Configure the Active Directory Connector service account username
  #   ad_domain_service_account_username = "your-service-account-username"
  #   # Configure the Active Directory Connector service account password
  #   ad_domain_service_account_password = "your-service-account-password"
  # }
  # Optionally configure the organization's user account configuration settings.
  # This is optional, and depends on your configuration.
  # user_account_configuration {
  #   # Configure the initial user password expiration duration, measured in days
  #   initial_password_duration_in_days = 30
  #   # Configure the user password expiration duration, measured in days
  #   password_duration_in_days = 90
  #   # Configure the user password complexity requirements
  #   password_complexity_requirements {
  #     # Configure the password complexity rules, like length, characters, etc.
  #     minimum_length = 8
  #     # Configure the password complexity rules, like length, characters, etc.
  #     minimum_lowercase_characters = 1
  #     # Configure the password complexity rules, like length, characters, etc.
  #     minimum_uppercase_characters = 1
  #     # Configure the password complexity rules, like length, characters, etc.
  #     minimum_numeric_characters = 1
  #     # Configure the password complexity rules, like length, characters, etc.
  #     minimum_special_characters = 1
  #   }
  #   # Optionally disable password complexity requirements
  #   # This is optional, and depends on your configuration
  #   disable_password_complexity = false
  #   # Configure the user password expiration interval, measured in days
  #   password_duration_in_days = 90
  # }
  # Optionally configure the organization's mailbox configuration settings.
  # This is optional, and depends on your configuration.
  # mailbox_configuration {
  #   # Configure the initial mailbox quota in GB
  #   initial_mailbox_quota = 10
  #   # Configure the mailbox quota in GB
  #   mailbox_quota = 10
  # }
  # Optionally configure the organization's retention policies.
  # This is optional, and depends on your configuration.
  # retention_policy {
  #   # Optionally enable the retention policy for the organization
  #   # Default is "ENABLED"
  #   # Optional, supported values: "ENABLED", "DISABLED"
  #   enable = "ENABLED"
  #   # Configure the retention policy duration, measured in days
  #   retention_duration_in_days = 90
  #   # Configure the retention policy type, which can be either "FOLDER" or "MAILBOX"
  #   retention_policy_type = "FOLDER"
  # }
}

# Create a WorkMail User
resource "aws_workmail_user" "main" {
  name = "john.doe" # Username for the WorkMail user
  # Configure the user's email address
  email = "john.doe@my-workmail-organization.com"
  # Configure the user's password
  password = "your-password"
  # Configure the user's role in the organization
  # Required for creating the user
  # Optional, supported values: "USER", "ADMIN"
  role = "USER"
  # Configure the user's display name
  # Optional
  display_name = "John Doe"
  # Configure the user's initial mailbox quota in GB
  # Optional
  # initial_mailbox_quota = 10
  # Configure the user's mailbox quota in GB
  # Optional
  # mailbox_quota = 10
  # Optionally configure the user's retention policy settings.
  # This is optional, and depends on your configuration.
  # retention_policy {
  #   # Optionally enable the retention policy for the user
  #   # Default is "ENABLED"
  #   # Optional, supported values: "ENABLED", "DISABLED"
  #   enable = "ENABLED"
  #   # Configure the retention policy duration, measured in days
  #   retention_duration_in_days = 90
  #   # Configure the retention policy type, which can be either "FOLDER" or "MAILBOX"
  #   retention_policy_type = "FOLDER"
  # }
  # Optionally disable the user's ability to receive mail
  # This is optional, and depends on your configuration
  # disable_email = false
  # Optionally disable the user's ability to send mail
  # This is optional, and depends on your configuration
  # disable_send_email = false
  # Optionally disable the user's ability to access their mailbox
  # This is optional, and depends on your configuration
  # disable_mailbox_access = false
  # Optionally disable the user's ability to view the address book
  # This is optional, and depends on your configuration
  # disable_address_book_access = false
  # Optionally disable the user's ability to view the calendar
  # This is optional, and depends on your configuration
  # disable_calendar_access = false
  organization_id = aws_workmail_organization.main.id
}

# Create a WorkMail Group
resource "aws_workmail_group" "main" {
  name = "my-workmail-group" # Name for your WorkMail group
  # Optionally configure the group's email address
  # This is optional, and depends on your configuration.
  # email = "my-workmail-group@my-workmail-organization.com"
  # Configure the group's role in the organization
  # Required for creating the group
  # Optional, supported values: "USER", "ADMIN"
  role = "USER"
  # Configure the group's display name
  # Optional
  # display_name = "My WorkMail Group"
  # Optionally configure the group's members
  # This is optional, and depends on your configuration.
  # members = ["john.doe@my-workmail-organization.com", "jane.doe@my-workmail-organization.com"]
  # Optionally enable or disable the group's ability to receive mail
  # This is optional, and depends on your configuration.
  # disable_email = false
  # Optionally enable or disable the group's ability to send mail
  # This is optional, and depends on your configuration.
  # disable_send_email = false
  organization_id = aws_workmail_organization.main.id
}

# Create a WorkMail Alias
resource "aws_workmail_alias" "main" {
  email = "alias@my-workmail-organization.com" # Email address for the alias
  # Configure the alias's associated user
  # Required for creating the alias
  user_id = aws_workmail_user.main.id
  # Optionally configure the alias's role in the organization
  # This is optional, and depends on your configuration.
  # role = "USER"
  # Optionally configure the alias's display name
  # This is optional, and depends on your configuration.
  # display_name = "Alias"
  # Optionally disable the alias's ability to receive mail
  # This is optional, and depends on your configuration.
  # disable_email = false
  # Optionally disable the alias's ability to send mail
  # This is optional, and depends on your configuration.
  # disable_send_email = false
  organization_id = aws_workmail_organization.main.id
}
  