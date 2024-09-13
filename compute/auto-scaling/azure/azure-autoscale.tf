
      resource "azurerm_autoscale_setting" "example" {
  name                = "example-autoscale"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  target_resource_type = "microsoft.compute/virtualmachines"
  target_resource_id   = azurerm_linux_virtual_machine.example.id
  profile {
    name               = "example-profile"
    capacity {
      minimum = 1
      maximum = 10
      default = 2
    }
    rules {
      metric_trigger {
        metric_namespace  = "Microsoft.Compute/"
        metric_name       = "PercentageCPU"
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window         = "PT5M"
        operator           = "GreaterThan"
        threshold           = 70
        cooldown_duration    = "PT5M"
        metric_resource_id = azurerm_linux_virtual_machine.example.id
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
      }
    }
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  # ...
}

resource "azurerm_resource_group" "example" {
  # ...
}
    