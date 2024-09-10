
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Alexa for Business Account
resource "aws_alexa_for_business_account" "main" {
  name = "my-alexa-for-business-account" # Name of the Alexa for Business account
  # Optional settings:
  # description = "My Alexa for Business account description"
  # kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
}

# Create an Alexa for Business Skill Group
resource "aws_alexa_for_business_skill_group" "main" {
  account_id = aws_alexa_for_business_account.main.id
  name       = "my-skill-group"

  # Optional settings:
  # description = "My Skill Group Description"
}

# Create an Alexa for Business Room
resource "aws_alexa_for_business_room" "main" {
  account_id   = aws_alexa_for_business_account.main.id
  name         = "my-room"
  description  = "My Room"
  profile_arn  = aws_alexa_for_business_room_profile.main.arn
  # Optional settings:
  # address = "My Room Address"
  # distance_units = "METERS"
  # timezone = "America/Los_Angeles"
}

# Create an Alexa for Business Room Profile
resource "aws_alexa_for_business_room_profile" "main" {
  account_id  = aws_alexa_for_business_account.main.id
  name        = "my-room-profile"
  # Optional settings:
  # description = "My Room Profile Description"
  # tags = {
  #   "key1" = "value1"
  # }
}

# Create an Alexa for Business User
resource "aws_alexa_for_business_user" "main" {
  account_id    = aws_alexa_for_business_account.main.id
  first_name    = "John"
  last_name     = "Doe"
  email         = "john.doe@example.com"
  # Optional settings:
  # directory_user_id = "1234567890"
  # phone_number  = "+1234567890"
  # tags           = {
  #   "key1" = "value1"
  # }
}

# Create an Alexa for Business Skill
resource "aws_alexa_for_business_skill" "main" {
  account_id = aws_alexa_for_business_account.main.id
  skill_id   = "amzn1.ask.skill.XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
  # Optional settings:
  # enablement_type = "ENABLED"
  # tags = {
  #   "key1" = "value1"
  # }
}

# Create an Alexa for Business Skill Group Association
resource "aws_alexa_for_business_skill_group_association" "main" {
  account_id = aws_alexa_for_business_account.main.id
  room_arn   = aws_alexa_for_business_room.main.arn
  skill_group_arn = aws_alexa_for_business_skill_group.main.arn
  # Optional settings:
  # tags = {
  #   "key1" = "value1"
  # }
}

# Create an Alexa for Business User Enrollment Code
resource "aws_alexa_for_business_user_enrollment_code" "main" {
  account_id = aws_alexa_for_business_account.main.id
  user_arn   = aws_alexa_for_business_user.main.arn
}

# Create an Alexa for Business Gateway Group
resource "aws_alexa_for_business_gateway_group" "main" {
  account_id = aws_alexa_for_business_account.main.id
  name       = "my-gateway-group"
  # Optional settings:
  # description = "My Gateway Group Description"
  # tags = {
  #   "key1" = "value1"
  # }
}

# Create an Alexa for Business Gateway
resource "aws_alexa_for_business_gateway" "main" {
  account_id = aws_alexa_for_business_account.main.id
  gateway_group_arn = aws_alexa_for_business_gateway_group.main.arn
  name      = "my-gateway"
  # Optional settings:
  # description = "My Gateway Description"
  # tags = {
  #   "key1" = "value1"
  # }
}

# Create an Alexa for Business Device
resource "aws_alexa_for_business_device" "main" {
  account_id    = aws_alexa_for_business_account.main.id
  device_name  = "my-device"
  device_type   = "ECHO_DOT"
  device_serial_number = "1234567890"
  # Optional settings:
  # mac_address   = "AA:BB:CC:DD:EE:FF"
  # software_version  = "1.2.3.4"
  # tags           = {
  #   "key1" = "value1"
  # }
  # room_arn        = aws_alexa_for_business_room.main.arn
}

# Create an Alexa for Business Device Association
resource "aws_alexa_for_business_device_association" "main" {
  account_id = aws_alexa_for_business_account.main.id
  device_arn  = aws_alexa_for_business_device.main.arn
  room_arn    = aws_alexa_for_business_room.main.arn
}

# Create an Alexa for Business Network Profile
resource "aws_alexa_for_business_network_profile" "main" {
  account_id = aws_alexa_for_business_account.main.id
  name       = "my-network-profile"
  # Optional settings:
  # description = "My Network Profile Description"
  # network_type = "WIFI"
  # tags = {
  #   "key1" = "value1"
  # }
}

# Create an Alexa for Business Network Profile Association
resource "aws_alexa_for_business_network_profile_association" "main" {
  account_id = aws_alexa_for_business_account.main.id
  device_arn  = aws_alexa_for_business_device.main.arn
  network_profile_arn = aws_alexa_for_business_network_profile.main.arn
}

# Create an Alexa for Business Voice Profile
resource "aws_alexa_for_business_voice_profile" "main" {
  account_id = aws_alexa_for_business_account.main.id
  user_arn   = aws_alexa_for_business_user.main.arn
}

# Create an Alexa for Business User Association
resource "aws_alexa_for_business_user_association" "main" {
  account_id = aws_alexa_for_business_account.main.id
  device_arn  = aws_alexa_for_business_device.main.arn
  user_arn    = aws_alexa_for_business_user.main.arn
}

# Create an Alexa for Business User Permissions
resource "aws_alexa_for_business_user_permissions" "main" {
  account_id = aws_alexa_for_business_account.main.id
  user_arn   = aws_alexa_for_business_user.main.arn
}

# Create an Alexa for Business Room Permission
resource "aws_alexa_for_business_room_permission" "main" {
  account_id = aws_alexa_for_business_account.main.id
  room_arn   = aws_alexa_for_business_room.main.arn
  user_arn   = aws_alexa_for_business_user.main.arn
}

# Create an Alexa for Business Skill Permission
resource "aws_alexa_for_business_skill_permission" "main" {
  account_id = aws_alexa_for_business_account.main.id
  skill_id   = "amzn1.ask.skill.XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
  user_arn   = aws_alexa_for_business_user.main.arn
}
  