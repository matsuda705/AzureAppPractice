resource "azurerm_app_service_source_control" "func_app_sourcecontrol" {
  app_id             = azurerm_linux_function_app.function_app.id
  repo_url           = "https://github.com/matsuda705/MKFuncionApp"
  branch             = "master"
  use_manual_integration = true
  use_mercurial      = false
}
