#!/bin/bash
set -e

export SVC_NAME="az-api-svc"
export NAMESPACE="az-api"

kubectl apply -k ./k8s --dry-run=client
kubectl apply -k ./k8s

kubectl port-forward svc/"$SVC_NAME" 7074:8080

kubectl delete -k ./k8s

###
kubectl delete po py-loop-pod
kubectl apply -f py-pod.yaml
sleep 5
kubectl get po

###
export ISTIO_NAMESPACE=aks-istio-system


istioctl verify-install --istioNamespace "$ISTIO_NAMESPACE" --revision 1.23
istioctl proxy-status --istioNamespace "$ISTIO_NAMESPACE"

export INGRESS_NAME=aks-istio-ingressgateway-external
export INGRESS_NS=aks-istio-ingress

export INGRESS_HOST=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')

echo $INGRESS_HOST
echo $INGRESS_PORT

export INGRESS_HOST=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "$INGRESS_HOST"
echo "$INGRESS_PORT"

# Example URLs (replace with actual IP/hostname):
# https://$INGRESS_HOST:443/productpage
# http://$INGRESS_HOST:80/productpage

export SECURE_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
export TCP_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="tcp")].port}')
