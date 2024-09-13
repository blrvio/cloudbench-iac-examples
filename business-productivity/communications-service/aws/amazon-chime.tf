
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um usuário do Amazon Chime
resource "aws_chime_user" "user" {
  email  = "user@example.com"
  user_id = "user-id"
  name   = "User Name"
}

# Crie uma sala de reunião do Amazon Chime
resource "aws_chime_meeting" "meeting" {
  meeting_id = "meeting-id"
  external_meeting_id = "external-meeting-id"
}

# Crie um convite para uma sala de reunião
resource "aws_chime_meeting_invitation" "invitation" {
  meeting_id = aws_chime_meeting.meeting.meeting_id
  attendee {
    email = "attendee@example.com"
  }
}

# Crie um registro de chamada para um usuário
resource "aws_chime_call_record" "record" {
  user_id  = aws_chime_user.user.user_id
  call_type = "inbound"
  call_id  = "call-id"
}

    