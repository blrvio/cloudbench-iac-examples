
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Configure recursos pré-lançados
}

# Crie um grupo de gerenciamento
resource "azurerm_management_group" "example" {
  name     = "example-mg"
  display_name = "Example Management Group"
  parent_id = "providers.azurerm.management_group.parent.id" # Substitua pelo ID do grupo pai
}

# Crie um grupo de gerenciamento pai (opcional)
resource "azurerm_management_group" "parent" {
  name     = "parent-mg"
  display_name = "Parent Management Group"
}

# Atribua uma política de gerenciamento ao grupo de gerenciamento
resource "azurerm_policy_assignment" "example" {
  name                = "example-policy-assignment"
  management_group_id = azurerm_management_group.example.id
  policy_definition_id = "{your policy definition id}" # Substitua pelo ID da definição de política
  scope               = "managementGroup/example-mg"
  display_name        = "Example Policy Assignment"
  enforcement_mode    = "Default"
}

    