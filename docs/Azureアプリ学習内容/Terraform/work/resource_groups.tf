resource "azurerm_resource_group" "rg" {
  name     = "mk-flask-appservice-rg-${random_integer.ri.result}"
  location = var.location
}
