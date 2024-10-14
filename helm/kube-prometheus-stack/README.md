# kube-prometheus-stack

## How to install kube-prometheus-stack

下記のコマンドにより Prometheus Operator の CRD をインストールする。

```bash
CRD_VERSION="v0.77.1"
CRD_MANIFEST_URL="https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/${CRD_VERSION}/example/prometheus-operator-crd"

kubectl apply --server-side -f "${CRD_MANIFEST_URL}/monitoring.coreos.com_alertmanagerconfigs.yaml" && \
    kubectl apply --server-side -f "${CRD_MANIFEST_URL}/monitoring.coreos.com_alertmanagers.yaml" && \
    kubectl apply --server-side -f "${CRD_MANIFEST_URL}/monitoring.coreos.com_podmonitors.yaml" && \
    kubectl apply --server-side -f "${CRD_MANIFEST_URL}/monitoring.coreos.com_probes.yaml" && \
    kubectl apply --server-side -f "${CRD_MANIFEST_URL}/monitoring.coreos.com_prometheusagents.yaml" && \
    kubectl apply --server-side -f "${CRD_MANIFEST_URL}/monitoring.coreos.com_prometheuses.yaml" && \
    kubectl apply --server-side -f "${CRD_MANIFEST_URL}/monitoring.coreos.com_prometheusrules.yaml" && \
    kubectl apply --server-side -f "${CRD_MANIFEST_URL}/monitoring.coreos.com_scrapeconfigs.yaml" && \
    kubectl apply --server-side -f "${CRD_MANIFEST_URL}/monitoring.coreos.com_servicemonitors.yaml" && \
    kubectl apply --server-side -f "${CRD_MANIFEST_URL}/monitoring.coreos.com_thanosrulers.yaml"
```

下記のコマンドにより kube-prometheus-stack をインストールする

```bash
pwd # ${repository_root}/helm/kube-prometheus-stack
ENV=tes
helmfile -e "${ENV}" -f helmfile.yaml apply
```
