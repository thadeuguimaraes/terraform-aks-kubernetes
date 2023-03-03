resource "azurerm_resource_group" "storage_account_resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s_matrix" {
  name                = "reload_cluster"
  location            = azurerm_resource_group.storage_account_resource_group.location
  resource_group_name = azurerm_resource_group.storage_account_resource_group.name
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

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s_matrix.kube_config_raw
  sensitive = true
}

resource "local_file" "kube_config" {
  content  = azurerm_kubernetes_cluster.k8s_matrix.kube_config_raw
  filename = "//home//thadeulinux//.kube//config"
}
