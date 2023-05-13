#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

pkill kubectl
helm uninstall -n monitoring grafana

PODS=$(kubectl get pods -n monitoring --no-headers 2>/dev/null | grep -v grafana | wc -l)
if [[ "$PODS" == 0 ]]; then
	kubectl delete namespace monitoring
fi

