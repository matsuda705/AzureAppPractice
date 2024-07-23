resource "azurerm_storage_account" "func_app_storage" {
  name                     = "mystorageplan${random_integer.ri.result}"
  resource_group_name      = azurerm_resource_group.function_app_rg.name
  location                 = azurerm_resource_group.function_app_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_linux_function_app" "function_app" {
  name                       = "mk-python-functionApp-${random_integer.ri.result}"
  location                   = azurerm_resource_group.function_app_rg.location
  resource_group_name        = azurerm_resource_group.function_app_rg.name
  service_plan_id            = azurerm_service_plan.app_func_service_plan.id
  storage_account_name       = azurerm_storage_account.func_app_storage.name
  storage_account_access_key = azurerm_storage_account.func_app_storage.primary_access_key
  site_config {
    application_stack {
      python_version = "3.9"
    }
  }
}

data "azurerm_function_app_host_keys" "api_key_data" {
  name                = azurerm_linux_function_app.function_app.name
  resource_group_name = azurerm_resource_group.function_app_rg.name
}
