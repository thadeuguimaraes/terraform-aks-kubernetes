resource "azurerm_resource_group" "rg_k8s_matrix" {
  name     = "storage_account_resource_group"
  location = var.location

  tags = local.common_tags
}

resource "azurerm_storage_account" "first_storage_account" {
  name                     = "thadeuguimaraes"
  resource_group_name      = azurerm_resource_group.rg_k8s_matrix.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = local.common_tags
}

resource "azurerm_storage_container" "first_container" {
  name                  = "imagens"
  storage_account_name  = azurerm_storage_account.first_storage_account.name
  container_access_type = "private"
}