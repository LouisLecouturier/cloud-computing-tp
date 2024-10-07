

resource "azurerm_service_plan" "tp2Plan" {
  name                = "pythonapp-plan"
  location            = var.location
  resource_group_name = var.azurerm_resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}


resource "azurerm_linux_web_app" "tp2PythonApp" {
  name                = "tp2PythonApp"
  resource_group_name = var.azurerm_resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.tp2Plan.id

  site_config {
    application_stack {
      python_version = "3.9"
    }
    always_on = true
  }

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    WEBSITE_RUN_FROM_PACKAGE       = "1"
  }

  timeouts {
    create = "30m"
    update = "30m"
  }
}

resource "azurerm_app_service_source_control" "tp2SourceControl" {
  app_id                 = azurerm_linux_web_app.tp2PythonApp.id
  repo_url               = "https://github.com/LouisLecouturier/cloud-computing-tp.git"
  branch                 = "master"
  use_manual_integration = true
}
