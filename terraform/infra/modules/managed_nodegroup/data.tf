data "cloudinit_config" "eks_node_group" {
  gzip          = false
  base64_encode = true
  boundary      = "MIMEBOUNDARY"

  part {
    content_type = local.cloudinit_contents.content_type
    content      = local.cloudinit_contents.content
  }
}
