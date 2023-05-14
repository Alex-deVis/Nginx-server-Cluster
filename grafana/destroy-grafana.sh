#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

fuser -k 3000/tcp
kubectl delete configmap -n monitoring nginx-dashboard-config
helm uninstall -n monitoring grafana

PODS=$(kubectl get pods -n monitoring --no-headers 2>/dev/null | grep -v grafana | wc -l)
if [[ "$PODS" == 0 ]]; then
	kubectl delete namespace monitoring
fi

