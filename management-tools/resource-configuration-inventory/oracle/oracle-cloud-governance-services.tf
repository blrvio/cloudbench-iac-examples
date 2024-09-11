
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud credentials
  tenancy_id     = "your_tenancy_id"
  user_ocid      = "your_user_ocid"
  fingerprint    = "your_fingerprint"
  private_key_path = "path/to/your/private/key"
}

# Create a policy
resource "oci_identity_policy" "main" {
  name             = "my-policy"
  compartment_id  = "your_compartment_id"
  statements { description = "Allow access to a service"
    effect        = "allow"
    actions        = ["oci_identity.listUsers"]
    resources      = ["*" ]
    conditions { key = "any"
      values = ["*" ]
    }
  }
}

# Assign policy to a group
resource "oci_identity_group" "main" {
  name             = "my-group"
  compartment_id  = "your_compartment_id"
  policy_assignments { policy_id = oci_identity_policy.main.id}
}

# Add user to group
resource "oci_identity_user" "main" {
  name             = "my-user"
  compartment_id  = "your_compartment_id"
  group_assignments { group_id = oci_identity_group.main.id}
}
  