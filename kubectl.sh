
kubectl apply -k ./k8s --dry-run=client

kubectl apply -k ./k8s

kubectl port-forward svc/az-api-svc 7074:8080

kubectl delete -k ./k8s


###
kubectl delete po py-loop-pod
kubectl apply -f py-pod.yaml
sleep 5
kubectl get po

###

istioctl verify-install --istioNamespace aks-istio-system --revision 1.23
istioctl proxy-status --istioNamespace aks-istio-system

export INGRESS_NAME=aks-istio-ingressgateway-external
export INGRESS_NS=aks-istio-ingress

export INGRESS_HOST=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')

echo $INGRESS_HOST
echo $INGRESS_PORT

export INGRESS_HOST=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo $INGRESS_HOST
echo $INGRESS_PORT

https://74.179.241.33:443/productpage

export SECURE_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
export TCP_INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="tcp")].port}')

http://74.179.241.33:80/productpage
