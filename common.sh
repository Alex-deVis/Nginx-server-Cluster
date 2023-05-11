#!/bin/bash

ensure_image() {
	if [[ -z "$1" ]]; then
		echo "ensure_image <image>"
		exit 1
	fi

	docker pull -q "$1"
	kind load docker-image -q "$1"
}

get_node_ip() {
	echo $(kubectl get nodes -o wide | tail -1 | awk '{print $6}')
}

