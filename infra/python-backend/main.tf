

resource "azurerm_service_plan" "tp2Plan" {
  name                = "pythonapp-plan"
  location            = var.location
  resource_group_name = var.azurerm_resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}

data "archive_file" "python_app" {
  type        = "zip"
  source_dir  = "${path.module}/app"
  output_path = "${path.module}/python_app.zip"
  excludes    = ["__pycache__", "*.pyc", "*.pyo"]
}

resource "azurerm_linux_web_app" "tp2Pythonapp" {
  name                = "python-app-service"
  resource_group_name = var.azurerm_resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.tp2Plan.id


  site_config {
    application_stack {
      python_version = "3.12"

    }
    always_on = true
  }

  zip_deploy_file = data.archive_file.python_app.output_path

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    WEBSITE_RUN_FROM_PACKAGE       = "1"
    PYTHON_ENABLE_GUNICORN         = "true"
  }
}

resource "azurerm_app_service_source_control" "tp2SourceControl" {
  app_id   = azurerm_linux_web_app.tp2Pythonapp.id
  repo_url = "https://github.com/yourusername/your-repo"
  branch   = "main"

  github_action_configuration {
    generate_workflow_file = true
    code_configuration {
      runtime_stack   = "python"
      runtime_version = "3.12"
    }
  }
}
