# プロバイダーの設定
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# リソースグループの作成
resource "azurerm_resource_group" "flutter-logic-sample" {
  name     = "flutter-logic-sample-app"
  location = "East Asia"
}

# Azure Static Web Appsの作成
resource "azurerm_static_web_app" "static_app" {
  name                = "flutter-static-web-app"
  resource_group_name = azurerm_resource_group.flutter-logic-sample.name
  location            = azurerm_resource_group.flutter-logic-sample.location
  sku_tier            = "Free" # 無料枠。必要に応じて "Standard" に変更
}