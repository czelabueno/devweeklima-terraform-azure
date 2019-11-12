
provider "azurerm" {
  subscription_id = "8a3b18bc-0956-4a70-9dcd-ebf0f32994f2"
  client_id       = "caa78e0d-dcbe-4d55-9567-d8f1e19b2f49"
  client_secret   = "${var.client_secret}"
  tenant_id       = "00feae2f-290d-4b3c-a815-df921de5c0db"
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



