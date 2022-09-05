data "azurerm_subnet" "az_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg_name
}

resource "azurerm_resource_group" "az_rg" {
  name     = var.rg_name
  location = var.rg_location
  tags     = var.tags
}

resource "azurerm_storage_account" "az_sa" {
  name                     = var.storage_acct_name
  resource_group_name      = azurerm_resource_group.az_rg.name
  location                 = azurerm_resource_group.az_rg.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type

  tags = var.tags
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [data.azurerm_subnet.az_subnet.id]
  }
}

resource "azurerm_private_endpoint" "az_pe" {
  name                = azurerm_storage_account.az_sa.name
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name
  subnet_id           = data.azurerm_subnet.az_subnet.id

  private_service_connection {
    name                           = var.priv_svc_connection_name
    private_connection_resource_id = azurerm_storage_account.az_sa.id
    is_manual_connection           = false
    subresource_names              = var.subresource_name
  }
}