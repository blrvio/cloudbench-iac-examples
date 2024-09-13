
      /*
 This is an example of an Azure portal Terraform configuration. Azure portal
 does not provide a way to be managed by Terraform as it is a
 management console, not a service. Instead, this example shows how
 to provision a simple Azure VM. It also includes a basic example of a
 security group.
*/

# Configure the Azure provider
provider "azurerm" {
  features {} # enables support for the latest features
}

# Create a Resource Group for the VM
resource "azurerm_resource_group" "rg" {
  name     = "example-rg"
  location = "westus2"
}

# Create a virtual network for the VM
resource "azurerm_virtual_network" "vnet" {
  name                = "example-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet for the VM
resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a security group for the VM
resource "azurerm_network_security_group" "nsg" {
  name                 = "example-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create an inbound security rule to allow SSH access
resource "azurerm_network_security_rule" "ssh" {
  name                 = "allow-ssh"
  priority             = 100
  direction            = "Inbound"
  access               = "Allow"
  protocol             = "Tcp"
  source_port_range    = "*"
  destination_port_range = "22"
  source_address_prefix = "*"
  destination_address_prefix = "*
  resource_group_name = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Create a network interface for the VM
resource "azurerm_network_interface" "nic" {
  name                 = "example-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_security_group_id = azurerm_network_security_group.nsg.id
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                 = "example-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                 = "Standard_A2_v2"
  network_interface_ids = [azurerm_network_interface.nic.id]
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

    