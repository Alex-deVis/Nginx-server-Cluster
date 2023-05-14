#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

kubectl apply -f "$DIR/monitoring-namespace.yaml"

# Add datasource and dashboard
kubectl create configmap nginx-dashboard-config --from-file="$DIR/nginx-dashboard.json" -n monitoring

# Install grafana
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install grafana bitnami/grafana -n monitoring -f "$DIR/values.yaml"

GRAFANA_POD=$(kubectl get pod -n monitoring | grep grafana | awk '{print $1}')
kubectl wait --for=condition=Ready pod/$GRAFANA_POD -n monitoring --timeout=5m

PASS=$(kubectl get secret grafana-admin --namespace monitoring -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 -d)
echo "Credentials: admin/$PASS"

kubectl port-forward -n monitoring svc/grafana 3000:3000 --address 0.0.0.0 &

