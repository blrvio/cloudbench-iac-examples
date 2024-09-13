
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Substitua por suas features desejadas
}

# Crie um workspace do Azure Machine Learning
resource "azurerm_machine_learning_workspace" "example" {
  name                = "example-workspace"
  location            = "westus2"
  resource_group_name = "example-resources"
  # Substitua por seus recursos desejados
  storage_account_name = "example-storage"
  application_insights_name = "example-appinsights"
  # Substitua por suas informações de chave desejadas
  key_vault_name     = "example-keyvault"
  # Substitua por seus dados de chave desejados
  #storage_account_key = "example-storage-key"
}

# Crie uma máquina virtual para o Workbench
resource "azurerm_linux_virtual_machine" "example" {
  name                       = "example-workbench-vm"
  location                   = "westus2"
  resource_group_name        = "example-resources"
  size                       = "Standard_B2s"
  network_interface_ids = [azurerm_network_interface.example.id]
  # Substitua por seus dados de chave desejados
  #admin_password           = "example-password"
  #admin_username          = "example-username"
  #source_image_reference {
  #  publisher = "Canonical"
  #  offer     = "UbuntuServer"
  #  sku       = "18.04-LTS"
  #  version   = "Latest"
  #}
  #os_disk {
  #  caching = "ReadWrite"
  #  storage_account_type = "Standard_LRS"
  #}
  #source_image_reference {
  #  publisher = "Canonical"
  #  offer     = "UbuntuServer"
  #  sku       = "18.04-LTS"
  #  version   = "Latest"
  #}
}

# Crie uma interface de rede para a máquina virtual
resource "azurerm_network_interface" "example" {
  name                = "example-workbench-nic"
  location            = "westus2"
  resource_group_name = "example-resources"
  # Substitua por sua rede virtual desejada
  # subnet_id           = azurerm_subnet.example.id
  # private_ip_address_allocation = "Dynamic"
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westus2"
}

    