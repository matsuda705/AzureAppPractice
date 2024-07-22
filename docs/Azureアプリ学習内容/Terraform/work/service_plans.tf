resource "azurerm_service_plan" "app_service_plan" {
  name                = "mk-flask-app-service-plan-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_service_plan" "app_func_service_plan" {
  name                = "myFuncServicePlan-${random_integer.ri.result}"
  location            = azurerm_resource_group.function_app_rg.location
  resource_group_name = azurerm_resource_group.function_app_rg.name
  os_type             = "Linux"
  sku_name            = "Y1"
}
