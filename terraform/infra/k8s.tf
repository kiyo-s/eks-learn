resource "terraform_data" "update_k8s_config" {
  triggers_replace = {
    cluster_endpoint = aws_eks_cluster.main.endpoint
  }
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${aws_eks_cluster.main.name} --region ${var.region}"
  }
}

resource "terraform_data" "install_crds" {
  for_each = toset(local.crd_manifest_urls)
  triggers_replace = {
    cluster_endpoint = aws_eks_cluster.main.endpoint
  }
  depends_on = [terraform_data.update_k8s_config]
  provisioner "local-exec" {
    command = "kubectl apply --server-side -f ${each.value}"
  }
}
