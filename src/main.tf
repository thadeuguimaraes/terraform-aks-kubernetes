resource "azurerm_resource_group" "rg_k8s_matrix" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s_matrix" {
  name                = "reload_cluster"
  location            = azurerm_resource_group.rg_k8s_matrix.location
  resource_group_name = azurerm_resource_group.rg_k8s_matrix.name
  dns_prefix          = "reload-cluster"

  default_node_pool {
    name       = "default"
    node_count = var.default_node_pool_count
    vm_size    = var.default_node_pool_size
  }

  identity {
    type = "SystemAssigned"
  }
}