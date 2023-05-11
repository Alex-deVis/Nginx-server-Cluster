#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

pkill kubectl
helm uninstall -n monitoring grafana
kubectl delete namespace monitoring

