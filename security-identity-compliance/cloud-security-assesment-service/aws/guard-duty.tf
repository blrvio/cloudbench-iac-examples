
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a GuardDuty detector
resource "aws_guardduty_detector" "main" {
  enable  = true
  # Define the finding publishing options
  finding_publishing_options {
    # Publish findings to CloudTrail
    cloudtrail {
      enable = true
    }
  }
}

# Create a GuardDuty filter
resource "aws_guardduty_filter" "main" {
  detector_id = aws_guardduty_detector.main.id
  name        = "my-guardduty-filter"
  # Define the filter criteria
  action {
    findings {
      # Define the actions to take on findings
      # For example, archive findings older than 30 days
      archive_findings {
        archive_after = 2592000 # 30 days in seconds
      }
    }
  }
  # Define the filter rules
  finding_criteria {
    # Filter by severity
    criterion {
      key     = "severity"
      values = ["HIGH"]
    }
    # Filter by resource type
    criterion {
      key     = "resource.type"
      values = ["AWS::S3::Bucket"]
    }
  }
}

# Create a GuardDuty invitation
resource "aws_guardduty_invitation_accepter" "main" {
  detector_id = aws_guardduty_detector.main.id
  # Accept the invitation from the specified account
  master_id = "123456789012" # Replace with the master account ID
}

  