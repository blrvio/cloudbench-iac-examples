
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region     = "us-ashburn-1"
  compartment = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
}

# Crie um tópico de notificação
resource "oci_notifications_topic" "example" {
  compartment_id = oci_compartment.example.id
  name          = "example-topic"
  display_name  = "Example Topic"
  description  = "Example Topic"
}

# Crie uma regra de notificação
resource "oci_notifications_rule" "example" {
  compartment_id = oci_compartment.example.id
  topic_id       = oci_notifications_topic.example.id
  name           = "example-rule"
  description    = "Example Rule"
  action         = "oci.action.notifications.send-email"
  is_enabled     = true
  actions        = {
    email_notification {
      subject       = "Example Notification"
      body          = "Example Notification Body"
      to_addresses = ["example@example.com"]
    }
  }
  conditions      = {
    event_type = "instance.create"
    namespace    = "oci.compute"
  }
}

# Crie um compartimento
resource "oci_compartment" "example" {
  name = "example-compartment"
  description = "Example Compartment"
}
    