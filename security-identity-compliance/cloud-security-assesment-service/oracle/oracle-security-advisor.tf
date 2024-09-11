
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Add your OCI credentials here
  #  For example, using environment variables:
  #  tenancy_ocid = var.tenancy_ocid
  #  user_ocid    = var.user_ocid
  #  fingerprint  = var.fingerprint
  #  private_key   = var.private_key
}

# Define the OCI Security Advisor resource
resource "oci_security_advisor_target" "example" {
  # Use the compartment OCI ID where the resource will be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  # Resource type for the Security Advisor target
  resource_type = "oci.core.Instance"
  # The unique identifier of the resource. 
  # Use the OCI resource ID
  resource_id = "ocid1.instance.oc1..aaaaaaaaxxxxxx"
}

# Define an OCI Security Advisor rule
resource "oci_security_advisor_rule" "example" {
  # Use the compartment OCI ID where the resource will be created
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  # Rule name
  name = "example-rule"
  # Rule description
  description = "Example Security Advisor rule"
  #  Type of the rule
  rule_type = "CUSTOM"
  #  Type of the resource that this rule applies to
  resource_type = "oci.core.Instance"
  # Severity of the rule. Valid values are CRITICAL, HIGH, MEDIUM, LOW
  severity = "MEDIUM"
  # The resource's OCI ID for which this rule is applied
  target_id = oci_security_advisor_target.example.id
  # Specify rule status
  #  Active rules are evaluated by the service and generate findings. 
  #  Inactive rules are not evaluated.
  status = "ACTIVE"
  # Custom rule condition. See the documentation for supported conditions.
  condition = "oci.core.Instance.isPubliclyAccessible == TRUE"
  # The remediation instruction for the rule.
  remediation_instruction = "Remediate the rule by disabling public access to the instance."
}

  