minikube start --kubernetes-version='v1.21.1' \
 --memory=4096 \
 --addons="metrics-server,default-storageclass,storage-provisioner" \
 -p monitoring-cluster

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm -n monitoring-cluster upgrade --install prometheus prometheus-community/kube-prometheus-stack -f kube-prometheus-stack/values.yaml --create-namespace --wait
helm dep up fast-api-webapp
helm -n fast-api upgrade my-app --wait --install --create-namespace fast-api-webapp