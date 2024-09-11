
    # Configure the Oracle Cloud provider
provider "oci" {
  # Set your tenancy OCID, user OCID, and private key file
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  user_ocid    = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  private_key_file = "~/.oci/oci_api_key.pem"
  region = "us-ashburn-1"
}

# Create a Visual Studio Code extension
resource "oci_devops_extension" "main" {
  # Specify the extension name
  name = "MyExtension"
  # The path to the extension's source code
  source = "path/to/extension/code"
  # The extension's type
  extension_type = "visualstudio"
  # The extension's description
  description = "My extension for Visual Studio Code"
}

# Create a Visual Studio Code workspace
resource "oci_devops_workspace" "main" {
  # Specify the workspace name
  name = "MyWorkspace"
  # The workspace's description
  description = "My Visual Studio Code workspace"
  # The workspace's configuration
  config = <<EOF
{
  "extensions": [
    "oci_devops_extension.main.id"
  ]
}
EOF
}

  