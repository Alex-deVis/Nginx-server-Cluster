#!/bin/bash

SCGC_HOME=$(dirname $(realpath "$0"))
NGINX_PATH="$SCGC_HOME/nginx"
PROMEXPORTER_PATH="$SCGC_HOME/promexporter"
PROMETHEUS_PATH="$SCGC_HOME/prometheus"
GRAFANA_PATH="$SCGC_HOME/grafana"


if [[ "$1" == "clean" ]]; then
	bash "$GRAFANA_PATH/destroy-grafana.sh"
	bash "$PROMETHEUS_PATH/destroy-prometheus.sh"
	bash "$PROMEXPORTER_PATH/destroy-promexporter.sh"
	bash "$NGINX_PATH/destroy-nginx.sh"
	bash "$SCGC_HOME/destroy-cluster.sh"
elif [[ "$1" == "secure" ]]; then
	bash "$SCGC_HOME/deploy-cluster.sh"
	bash "$NGINX_PATH/deploy-nginx.sh" "secure"
	bash "$PROMEXPORTER_PATH/deploy-promexporter.sh"
	bash "$PROMETHEUS_PATH/deploy-prometheus.sh"
	bash "$GRAFANA_PATH/deploy-grafana.sh"
else
	bash "$SCGC_HOME/deploy-cluster.sh"
	bash "$NGINX_PATH/deploy-nginx.sh"
	bash "$PROMEXPORTER_PATH/deploy-promexporter.sh"
	bash "$PROMETHEUS_PATH/deploy-prometheus.sh"
	bash "$GRAFANA_PATH/deploy-grafana.sh"
fi

