#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

fuser -k 9090/tcp
helm uninstall -n monitoring prometheus
kubectl delete namespace monitoring

