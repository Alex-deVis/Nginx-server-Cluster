# Nginx-server Cluster

*Nginx-server Cluster* is a cluster containing `nginx`, `Prometheus`, and `Grafana` services to serve simple html documents and statistics of the `nginx` service.

## Convenience Deployment

```console
# Deploy all services
./one-to-rule-them-all

# Remove all services
./one-to-rule-them-all clean

# Deploy all services and turn on ngins security features
./one-to-rule-them-all secure
```

## Manual Deployment

Deploy the cluster with `./deploy-cluster` from the root directory.

Each component (`nginx`, `promexporter`, `prometheus`, `grafana`) has its manifest files in a directory with the same name.
There you can also find `deploy-$service.sh` and `destroy-$service.sh`, which are used for setting up and removing the service.
`deploy-$service.sh` will also run functionality tests to confirm the deployment.

```console
# Deploy nginx
student@lab-kubernetes:~/scgc/nginx$ ./deploy-nginx.sh
configmap/nginx-html-config created
configmap/nginx-metrics-config created
deployment.apps/nginx created
service/nginx created
pod/nginx-8ddbb6569-qt4qs condition met


Test:
<html><body>Not everybody can be bombardier!</body></html>
Active connections: 1
server accepts handled requests
 2 2 2
Reading: 0 Writing: 1 Waiting: 0
```

```console
# Remove nginx
student@lab-kubernetes:~/scgc/nginx$ ./destroy-nginx.sh
configmap "nginx-html-config" deleted
configmap "nginx-metrics-config" deleted
Error from server (NotFound): error when deleting "/home/student/scgc/nginx/nginx-secure-config.yaml": configmaps "nginx-secure-config" not found
deployment.apps "nginx" deleted
Error from server (NotFound): error when deleting "/home/student/scgc/nginx/nginx-secure-deployment.yaml": deployments.apps "nginx" not found
service "nginx" deleted

# The "NotFound" messages appear due to the simplicity of the destroy-script,
# that does not bother to check whether a manfiest was deployed before deleting it
```

### Security

You can pass `secure` as argument for `deploy-nginx.sh` to deploy `nginx` with security features: request rate limit for user, limited connections for user and timeout for slow clients.
You can find their implementation in `nginx/nginx-secure-config.yaml`.

```console
# Deploy nginx with security features
student@lab-kubernetes:~/scgc/nginx$ ./deploy-nginx.sh secure
configmap/nginx-html-config created
configmap/nginx-metrics-config created
configmap/nginx-secure-config created
deployment.apps/nginx created
service/nginx created
pod/nginx-6b6db74b54-dsp84 condition met


Test:
<html><body>Not everybody can be bombardier!</body></html>
Active connections: 2
server accepts handled requests
 3 3 4
Reading: 0 Writing: 1 Waiting: 1
```

## `DoS` Testing

Use `run_slowhttptest.sh <output>` from `slowhttptest/` to run the attack with the same name.
It will store the results as `stats_nginx.csv` and `stats_nginx.html` if no value for `output` is provided.
