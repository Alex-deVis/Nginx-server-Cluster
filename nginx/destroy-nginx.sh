#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

kubectl delete -f "$DIR/nginx-html-config.yaml"
kubectl delete -f "$DIR/nginx-metrics-config.yaml"
kubectl delete -f "$DIR/nginx-deployment.yaml"
kubectl delete -f "$DIR/nginx-service.yaml"

