
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaax77777777777777777777777777777"
  # Use an environment variable or file to securely store your API key
  # Please refer to the OCI Terraform documentation for more details on how to securely store the API key.
  # [https://registry.terraform.io/providers/hashicorp/oci/latest/docs/guides/getting-started](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/guides/getting-started)
  # You can also use a dedicated Terraform credential helper for OCI (ocicli)
}

# Create a new Identity Cloud Service user
resource "oci_identity_user" "main" {
  name = "terraform-user"
  # Optional: Create the user in a specific compartment
  compartment_id = "ocid1.compartment.oc1..aaaaaaaax77777777777777777777777777777"
}

# Create a group and add the user to it
resource "oci_identity_group" "main" {
  name = "terraform-group"
  # Optional: Create the group in a specific compartment
  compartment_id = "ocid1.compartment.oc1..aaaaaaaax77777777777777777777777777777"
}

resource "oci_identity_group_membership" "main" {
  group_id = oci_identity_group.main.id
  user_id = oci_identity_user.main.id
}

# Create a policy to grant the user access to a specific resource
resource "oci_identity_policy" "main" {
  name = "terraform-policy"
  # Optional: Create the policy in a specific compartment
  compartment_id = "ocid1.compartment.oc1..aaaaaaaax77777777777777777777777777777"
  statements = [
    {
      effect = "ALLOW"
      actions = ["manage"]
      resources = ["ocid1.resource.oc1..aaaaaaaax77777777777777777777777777777"]
    }
  ]
}
  