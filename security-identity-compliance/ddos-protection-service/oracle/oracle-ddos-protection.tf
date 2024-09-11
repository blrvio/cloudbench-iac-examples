
    # Configure the Oracle provider
provider "oci" {
  region = "us-ashburn-1"
  # Add your credentials here
}

# Create a DDoS protection rule
resource "oci_network_ddos_protection_rule" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name = "my-ddos-protection-rule"
  # Define the DDoS protection rule actions
  actions = [
    "BLOCK",
    "LOG"
  ]
  # Define the DDoS protection rule targets
  targets = [
    "ocid1.instance.oc1..aaaaaaaaxxxxxx"
  ]
}

# Create a DDoS protection rule set
resource "oci_network_ddos_protection_rule_set" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name = "my-ddos-protection-rule-set"
  # Attach the DDoS protection rule to the rule set
  rules = [oci_network_ddos_protection_rule.main.id]
}

# Create a DDoS protection policy
resource "oci_network_ddos_protection_policy" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name = "my-ddos-protection-policy"
  # Define the DDoS protection policy actions
  actions = [
    "BLOCK",
    "LOG"
  ]
  # Define the DDoS protection policy targets
  targets = [
    "ocid1.networksecuritygroup.oc1..aaaaaaaaxxxxxx"
  ]
}

  