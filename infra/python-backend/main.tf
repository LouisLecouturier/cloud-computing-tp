

resource "azurerm_service_plan" "tp2Plan" {
  name                = "pythonapp-plan"
  location            = var.location
  resource_group_name = var.azurerm_resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}

data "archive_file" "tp2PythonApp" {
  type        = "zip"
  source_dir  = "${path.module}/../../python/"
  output_path = "${path.module}/python_app.zip"
  excludes    = ["__pycache__", "*.pyc", "*.pyo", ".venv"]
}

resource "azurerm_linux_web_app" "tp2PythonApp" {
  name                = "tp2PythonApp"
  resource_group_name = var.azurerm_resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.tp2Plan.id


  site_config {
    application_stack {
      python_version = "3.12"
    }
    always_on = true
  }

  zip_deploy_file = data.archive_file.tp2PythonApp.output_path

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    WEBSITE_RUN_FROM_PACKAGE       = "1"
    STARTUP_COMMAND                = "uvicorn main:app --host 0.0.0.0 --port 8000"
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
  use_mercurial          = false


}
