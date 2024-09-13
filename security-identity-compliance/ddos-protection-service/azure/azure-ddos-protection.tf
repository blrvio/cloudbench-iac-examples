
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Se você estiver usando o Azure Resource Manager (ARM)
}

# Crie um plano de proteção DDoS
resource "azurerm_ddos_protection_plan" "example" {
  name                = "example-ddos-protection-plan"
  resource_group_name = "example-resources"
  location            = "westus"
}

# Crie uma rede virtual e configure o plano de proteção DDoS para ela
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = "example-resources"
  location            = "westus"
  address_space       = ["10.0.0.0/16"]
  ddos_protection_plan_id = azurerm_ddos_protection_plan.example.id
}

# Crie uma sub-rede na rede virtual
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = "example-resources"
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Crie uma máquina virtual dentro da sub-rede com o plano de proteção DDoS
resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  resource_group_name = "example-resources"
  location            = "westus"
  size                = "Standard_B2s"
  network_interface_ids = [azurerm_network_interface.example.id]
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  # ... (demais configurações da VM)
}

# Crie uma interface de rede dentro da sub-rede
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  resource_group_name = "example-resources"
  location            = "westus"
  virtual_network_id = azurerm_virtual_network.example.id
  subnet_id          = azurerm_subnet.example.id
  # ... (demais configurações da interface de rede)
}
    