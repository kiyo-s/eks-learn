locals {
  cloudinit_contents = {
    content_type = "application/node.eks.aws"
    content = base64encode(templatefile("${path.module}/templates/userdata.tpl", {
      cluster_name     = var.eks_cluster_name
      cluster_endpoint = var.cluster_endpoint
      cluster_ca       = var.cluster_ca
      cluster_cidr     = var.cluster_cidr
    }))
  }
}
