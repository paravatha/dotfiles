brew upgrade helm

helm repo add kedacore https://kedacore.github.io/charts
helm repo update
helm install keda kedacore/keda --namespace keda --create-namespace

helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace

## add this helm repository
helm repo add airflow-stable https://airflow-helm.github.io/charts
helm repo update

## set the release-name & namespace
export AIRFLOW_NAME="airflow-cluster"
export AIRFLOW_NAMESPACE="airflow-cluster"

## create the namespace
kubectl create ns "$AIRFLOW_NAMESPACE"

## install using helm 3
helm install "$AIRFLOW_NAME" airflow-stable/airflow --namespace "$AIRFLOW_NAMESPACE" --version "8.9.0" --set airflow.image.tag=2.4.1-python3.9 --set dags.persistence.enabled=True --set dags.persistence.accessMode=ReadWriteMany

helm upgrade "$AIRFLOW_NAME" airflow-stable/airflow --namespace "$AIRFLOW_NAMESPACE" --version "8.9.0" --set airflow.image.tag=2.9.2-python3.9 --set dags.persistence.enabled=True --set dags.persistence.accessMode=ReadWriteMany --set extraPipPackages="apache-airflow-providers-databricks==6.6.0"

helm uninstall "$AIRFLOW_NAME" --namespace "$AIRFLOW_NAME"

airflow scheduler

helm list --all-namespaces   
  
