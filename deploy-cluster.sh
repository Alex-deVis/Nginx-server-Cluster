#!/bin/bash

# Install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && bash get_helm.sh
# Install slowhttptest
sudo apt install slowhttptest

kind create cluster

kubectl wait --for=condition=Ready nodes --all --timeout=5m
kubectl get pods -A

