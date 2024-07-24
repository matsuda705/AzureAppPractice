resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webapp.id
  repo_url           = "https://github.com/matsuda705/AzureAppPractice"
  branch             = "deploy-webui"
  use_manual_integration = true
  use_mercurial      = false
}