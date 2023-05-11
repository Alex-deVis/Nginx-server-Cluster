#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

#ensure_image "nginx:latest"

kubectl apply -f "$DIR/nginx-html-config.yaml"
kubectl apply -f "$DIR/nginx-metrics-config.yaml"
kubectl apply -f "$DIR/nginx-deployment.yaml"
kubectl apply -f "$DIR/nginx-service.yaml"

kubectl wait --for=condition=Ready pod -l app=nginx --timeout=5m

printf "\n\nTest:\n"
NODE_IP=$(get_node_ip)
curl http://$NODE_IP:30080
curl http://$NODE_IP:30088/metrics

