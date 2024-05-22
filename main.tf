provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "RG-Terraform" {
  name     = "terraform-resource-group"
  location = "Southeast Asia"
}

resource "azurerm_service_plan" "ASP-Terraform" {
  name                = "terraform-appserviceplan"
  location            = azurerm_resource_group.RG-Terraform.location
  resource_group_name = azurerm_resource_group.RG-Terraform.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "AS-Terraform" {
  name                = "app-service-terraform-srgovin"
  resource_group_name = azurerm_resource_group.RG-Terraform.name
  location            = azurerm_resource_group.RG-Terraform.location
  service_plan_id     = azurerm_service_plan.ASP-Terraform.id

  site_config {
  
  }
  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_mssql_server.terraform-sqlserver.fully_qualified_domain_name} Database=${azurerm_mssql_database.terraform-sqldatabase.name};User ID=${azurerm_mssql_server.terraform-sqlserver.administrator_login};Password=${azurerm_mssql_server.terraform-sqlserver.administrator_login_password};Trusted_Connection=False;Encrypt=True;"
   # value = "Server=tcp:${azurerm_sql_server.terraform-sqlserver.fully_qualified_domain_name} Database=${azurerm_sql_database.terraform-sqldatabase.name};User ID=${azurerm_sql_server.terraform-sqlserver.administrator_login};Password=${azurerm_sql_server.terraform-sqlserver.administrator_login_password};Trusted_Connection=False;Encrypt=True;"
  }
}
resource "azurerm_mssql_server" "terraform-sqlserver" {
  name                          = "terraform-sqlserver"
  resource_group_name           = azurerm_resource_group.RG-Terraform.name
  location                      = azurerm_resource_group.RG-Terraform.location
  version                       = "12.0"
  administrator_login           = "houssem"
  administrator_login_password  = "4-v3ry-53cr37-p455w0rd"
  minimum_tls_version           = "1.2"
}

resource "azurerm_mssql_database" "terraform-sqldatabase" {
  name                = "terraform-sqldatabase"
  server_id         = azurerm_mssql_server.terraform-sqlserver.id

  tags = {
    environment = "production"
  }
}