#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

#ensure_image "quay.io/prometheus/prometheus:v2.43.1"
ensure_image "registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.8.0"

kubectl create namespace monitoring

# Install prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus -n monitoring -f "$DIR/values.yaml"

PROMETHEUS_SERVER=$(kubectl get pod -n monitoring | grep server | awk '{print $1}')
kubectl wait --for=condition=Ready pod/$PROMETHEUS_SERVER -n monitoring --timeout=5m

kubectl port-forward -n monitoring $PROMETHEUS_SERVER 9090:9090 --address 0.0.0.0 &

