# Criação do cluster
resource "azurerm_kubernetes_cluster" "k8s_matrix" {
  name                = var.k8s_matrix
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "reload"

  default_node_pool {
    name       = "default"
    node_count = var.default_node_pool_count
    vm_size    = var.default_node_pool_size
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "local_file" "kube_config" {
  content  = azurerm_kubernetes_cluster.k8s_matrix.kube_config_raw
  filename = "//home//thadeulinux//.kube//config"
}