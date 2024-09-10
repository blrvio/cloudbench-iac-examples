
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon Connect Instance
resource "aws_connect_instance" "main" {
  instance_id  = "your-instance-id" # Unique identifier for your Connect instance
  instance_alias = "your-instance-alias" # User-friendly name for your Connect instance
  # Optionally set the instance type
  # instance_type = "STANDARD"
  # Set the directory used for user authentication
  directory_type = "USER_POOL"
  # Configure the user pool details
  user_pool_config {
    user_pool_id = "your-user-pool-id" # Your user pool ID
    # Set the user pool roles for authentication
    roles = {
      # Map the Amazon Connect user roles to your user pool roles
      "agent" = "your-user-pool-role"
      "admin" = "your-user-pool-role"
    }
  }
}

# Create a Contact Flow
resource "aws_connect_contact_flow" "main" {
  instance_id = aws_connect_instance.main.instance_id
  name        = "your-contact-flow-name" # Name of your contact flow
  # Configure the contact flow's content
  content = <<EOF
    {
      "Version": "2019-10-01",
      "Metadata": {
        "Arn": "arn:aws:connect:us-east-1:123456789012:instance/your-instance-id/contact-flow/your-contact-flow-name",
        "CreationDateTime": "2023-03-01T12:00:00Z",
        "LastModifiedDateTime": "2023-03-01T12:00:00Z",
        "Name": "your-contact-flow-name"
      },
      "Content": {
        "Type": "CONTACT_FLOW",
        "Metadata": {
          "Description": "Your contact flow description",
          "Tags": {
            "key1": "value1",
            "key2": "value2"
          }
        },
        "Content": [
          {
            "Type": "START_CONTACT_FLOW",
            "Id": "StartContactFlow",
            "Next": "your-next-step"
          },
          {
            "Type": "your-next-step",
            # Configure your contact flow steps
            "Next": "your-next-step"
          }
        ]
      }
    }
EOF
}

# Create a Contact Flow Module
resource "aws_connect_contact_flow_module" "main" {
  instance_id = aws_connect_instance.main.instance_id
  name        = "your-contact-flow-module-name"
  content = <<EOF
    {
      "Version": "2019-10-01",
      "Metadata": {
        "Arn": "arn:aws:connect:us-east-1:123456789012:instance/your-instance-id/contact-flow-module/your-contact-flow-module-name",
        "CreationDateTime": "2023-03-01T12:00:00Z",
        "LastModifiedDateTime": "2023-03-01T12:00:00Z",
        "Name": "your-contact-flow-module-name"
      },
      "Content": {
        "Type": "CONTACT_FLOW_MODULE",
        "Metadata": {
          "Description": "Your contact flow module description",
          "Tags": {
            "key1": "value1",
            "key2": "value2"
          }
        },
        "Content": [
          {
            "Type": "your-step-type",
            "Id": "your-step-id",
            "Next": "your-next-step"
          },
          {
            "Type": "your-next-step",
            # Configure your contact flow module steps
            "Next": "your-next-step"
          }
        ]
      }
    }
EOF
}

# Create a Queue
resource "aws_connect_queue" "main" {
  instance_id = aws_connect_instance.main.instance_id
  name        = "your-queue-name"
  description = "Your queue description"
  # Set the queue's maximum number of contacts
  # max_contacts = 100
  # Set the queue's priority
  # priority = 1
  # Set the queue's status
  # status = "ENABLED"
}

# Create a User
resource "aws_connect_user" "main" {
  instance_id = aws_connect_instance.main.instance_id
  user_id     = "your-user-id" # Unique identifier for your user
  username     = "your-username" # User's username
  # Set the user's password
  # password = "your-password"
  # Set the user's phone number
  # phone_number = "your-phone-number"
  # Set the user's security profile
  # security_profile_ids = ["your-security-profile-id"]
  # Set the user's user type
  # user_type = "AGENT"
  # Set the user's attributes
  # attributes = {
  #   "your-attribute-name" = "your-attribute-value"
  # }
}

# Create a Security Profile
resource "aws_connect_security_profile" "main" {
  instance_id  = aws_connect_instance.main.instance_id
  security_profile_name = "your-security-profile-name"
  # Configure the security profile's permissions
  permissions = [
    "admin",
    "agent"
  ]
}

# Create a Routing Profile
resource "aws_connect_routing_profile" "main" {
  instance_id = aws_connect_instance.main.instance_id
  name        = "your-routing-profile-name"
  # Configure the routing profile's queue assignments
  queue_config {
    queue_id = aws_connect_queue.main.queue_id
    # Set the routing profile's queue weight
    # weight = 1
  }
  # Set the routing profile's default outbound queue
  # default_outbound_queue_id = aws_connect_queue.main.queue_id
  # Set the routing profile's default inbound queue
  # default_inbound_queue_id = aws_connect_queue.main.queue_id
  # Set the routing profile's media streams
  # media_streams = [
  #   "VOICE"
  # ]
}

  