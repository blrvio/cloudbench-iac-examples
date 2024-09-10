
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-autoscale-rg"
  location = "westus"
}

# Create a virtual machine scale set
resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                 = "example-autoscale-vmss"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku {
    name = "Standard_A2_v2"
    tier = "Standard"
  }
  # Configure the VMSS with the desired number of instances
  # The autoscale settings will adjust this number dynamically
  capacity = 2
  # Set the VMSS's availability zone
  zones   = ["1","2","3"]
  # Set a storage account for the VMSS
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }
  # Configure the VMSS with an OS disk
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  # Configure the VMSS with network settings
  # Ensure network connectivity for the VMs
  network_interface {
    name = "example-autoscale-nic"
    # Configure the network interface with a static IP address
    ip_configuration {
      name = "example-autoscale-ip-config"
      # Use a subnet for the network interface
      subnet_id = azurerm_subnet.example.id
    }
  }
}

# Create a subnet
resource "azurerm_subnet" "example" {
  name                 = "example-autoscale-subnet"
  resource_group_name = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a virtual network
resource "azurerm_virtual_network" "example" {
  name                 = "example-autoscale-vnet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# Create an autoscale setting
resource "azurerm_autoscale_setting" "example" {
  name                 = "example-autoscale-setting"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.example.id
  # Configure the scaling rules for the autoscale setting
  profile {
    name = "example-autoscale-profile"
    # Use a fixed capacity of 2 as an example
    capacity {
      default = 2
    }
    # Configure the scaling rules with metrics and actions
    rule {
      # Define the metric used for scaling
      metric_trigger {
        metric_namespace  = "Microsoft.Compute"
        metric_name      = "PercentageCPU"
        time_aggregation  = "Average"
        time_grain        = "PT1M"
        statistic         = "Average"
        time_window       = "PT5M"
        operator          = "GreaterThanOrEqual"
        threshold          = 70
      }
      # Configure the scaling actions for the rule
      scale_action {
        # Add one instance if the CPU utilization is above 70%
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
        cooldown  = "PT5M"
      }
    }
  }
}

  