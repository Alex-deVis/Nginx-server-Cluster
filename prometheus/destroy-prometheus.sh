#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

fuser -k 9090/tcp
helm uninstall -n monitoring prometheus

PODS=$(kubectl get pods -n monitoring --no-headers 2>/dev/null | grep -v prometheus | wc -l)
if [[ "$PODS" == 0 ]]; then
	kubectl delete namespace monitoring
fi

