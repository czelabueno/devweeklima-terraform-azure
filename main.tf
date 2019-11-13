
provider "azurerm" {
  subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  client_id       = "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
  client_secret   = "${var.client_secret}"
  tenant_id       = "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
}

resource "azurerm_resource_group" "devweek_rg" {
  name     = "demodevweeklima"
  location = "eastus2"
  tags = {
    createdBy="Terraform"
  }
}

module "stac_website"{
  source = "./stac-website"
  resource_group = "${azurerm_resource_group.devweek_rg.name}"
}

module "az_function" {
  source = "./az-functions"
  resource_group = "${azurerm_resource_group.devweek_rg.name}"
  stac_primary_cnn_string = "${module.stac_website.stac_primary_cnn_string}"
}



