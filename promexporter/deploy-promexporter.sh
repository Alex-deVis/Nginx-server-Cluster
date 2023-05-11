#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

#ensure_image "nginx/nginx-prometheus-exporter:0.10.0"

kubectl apply -f "$DIR/promexporter-deployment.yaml"
kubectl apply -f "$DIR/promexporter-service.yaml"

kubectl wait --for=condition=Ready pod -l app=promexporter --timeout=5m

printf "\n\nTest:\n"
NODE_IP=$(get_node_ip)
curl http://$NODE_IP:30113

