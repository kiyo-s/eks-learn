locals {
  state     = "infra"
  managedby = "terraform"
  git_repos = "https://github.com/kiyo-s/eks-learn.git"
  name      = "eks-learn-${var.env}-${local.state}"

  default_tags = {
    Env           = var.env
    State         = local.state
    ManagedBy     = local.managedby
    GitRepository = local.git_repos
    Name          = local.name
  }

  prometheus_operator_version = "0.79.0"
  prometheus_operator_crd_manifest_urls = [
    "https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v${local.prometheus_operator_version}/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagerconfigs.yaml",
    "https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v${local.prometheus_operator_version}/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml",
    "https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v${local.prometheus_operator_version}/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml",
    "https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v${local.prometheus_operator_version}/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml",
    "https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v${local.prometheus_operator_version}/example/prometheus-operator-crd/monitoring.coreos.com_prometheusagents.yaml",
    "https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v${local.prometheus_operator_version}/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml",
    "https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v${local.prometheus_operator_version}/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml",
    "https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v${local.prometheus_operator_version}/example/prometheus-operator-crd/monitoring.coreos.com_scrapeconfigs.yaml",
    "https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v${local.prometheus_operator_version}/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml",
    "https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v${local.prometheus_operator_version}/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml",
  ]

  crd_manifest_urls = concat(
    local.prometheus_operator_crd_manifest_urls
  )
}
