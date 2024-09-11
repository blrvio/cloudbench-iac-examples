
    # Configure the Oracle provider
provider "oci" {
  # Configure the region, tenancy, user ocid, and key file
  region = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaay3p76l66"
  user = "ocid1.user.oc1..aaaaaaaax9k5b674"
  key_file = "~/.oci/config"  
}

# Create an IAM group
resource "oci_iam_group" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaawg7a3c7w"
  name = "example-group"
  description = "Example IAM group"
}

# Create an IAM policy
resource "oci_iam_policy" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaawg7a3c7w"
  name = "example-policy"
  description = "Example IAM policy"
  statements {    
    effect = "ALLOW"
    actions = ["oci_identity.manage_groups"]
    resources = ["*"]
  }
}

# Attach the IAM policy to the IAM group
resource "oci_iam_group_policy_attachment" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaawg7a3c7w"
  group_id = oci_iam_group.example.id
  policy_id = oci_iam_policy.example.id
}
  