#!/bin/bash

DIR=$(dirname $(realpath "$0"))
SCGC_HOME="$(dirname "$DIR")"

source "$SCGC_HOME/common.sh"

kubectl delete -f "$DIR/promexporter-deployment.yaml"
kubectl delete -f "$DIR/promexporter-service.yaml"

