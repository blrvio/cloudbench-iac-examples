
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region  = "us-ashburn-1" # Substitua pela sua região desejada
  tenancy = "ocid1.tenancy.oc1..aaaaaaaabbbbbbbbbbcccccccc"
  user    = "ocid1.user.oc1..aaaaaaaabbbbbbbbbbcccccccc"
  fingerprint = "xxxxxxxxx"
}

# Crie um remetente de email
resource "oci_email_sender" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaabbbbbbbbbbcccccccc"
  display_name   = "Example Sender"
  sender_type     = "STANDARD"
}

# Crie uma campanha de email
resource "oci_email_campaign" "example" {
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaabbbbbbbbbbcccccccc"
  sender_id       = oci_email_sender.example.id
  display_name     = "Example Campaign"
  subject         = "Example Subject"
  content_type     = "TEXT"
  content          = "Example content"
}

# Crie um grupo de destinatários
resource "oci_email_recipient_group" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaabbbbbbbbbbcccccccc"
  display_name  = "Example Recipient Group"

  recipients {
    type     = "EMAIL"
    recipient = "example@example.com"
  }
}

# Crie um envio de email
resource "oci_email_send" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaabbbbbbbbbbcccccccc"
  campaign_id    = oci_email_campaign.example.id
  recipient_group_id = oci_email_recipient_group.example.id
}
    