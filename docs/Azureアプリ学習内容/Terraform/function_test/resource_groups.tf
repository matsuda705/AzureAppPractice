resource "azurerm_resource_group" "function_app_rg" {
  name     = "mk-flask-function-app-rg-${random_integer.ri.result}"
  location = var.location
}
