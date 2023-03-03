output "storage_account_id" {
  value = azurerm_storage_account.first_storage_account.id
}

output "storage_container_id" {
  value = azurerm_storage_container.first_container.id
}

output "resource_group_id" {
  value = azurerm_resource_group.rg_k8s_matrix.id
}
