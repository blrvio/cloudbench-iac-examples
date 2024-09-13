
      # Configure o provedor do Oracle Cloud Infrastructure
provider "oci" {
  region = "us-ashburn-1" # Substitua pela sua região desejada
  # Credenciais de autenticação devem ser configuradas como variáveis de ambiente
}

# Crie um grupo de gerenciamento de sistema operacional
resource "oci_os_management_management_group" "example" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaw7g7zq5r"
  display_name   = "My Management Group"
  description    = "My Management Group Description"
  is_default     = false
  is_system_group = false
  state          = "ENABLED"
}

# Crie uma política de gerenciamento de sistema operacional
resource "oci_os_management_policy" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7g7zq5r"
  display_name  = "My Policy"
  description   = "My Policy Description"
  management_group_id = oci_os_management_management_group.example.id
  policy_content = "{}"
  state = "ENABLED"
}

# Crie uma tarefa de gerenciamento de sistema operacional
resource "oci_os_management_task" "example" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaw7g7zq5r"
  display_name   = "My Task"
  description    = "My Task Description"
  management_group_id = oci_os_management_management_group.example.id
  policy_id = oci_os_management_policy.example.id
  state = "ENABLED"
}

# Crie um agente de gerenciamento de sistema operacional
resource "oci_os_management_agent" "example" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaw7g7zq5r"
  display_name   = "My Agent"
  description    = "My Agent Description"
  management_group_id = oci_os_management_management_group.example.id
  agent_type = "AGENT_TYPE_UNSPECIFIED"
  state = "ENABLED"
}

    