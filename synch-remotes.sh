#!/bin/sh
cd $(dirname `[[ $0 = /* ]] && echo "$0" || echo "$PWD/${0#./}"`)

mkdir tmp
cd tmp
# git clone https://github.com/gravitee-io/gravitee-kubernetes.git && rm -rf gravitee-kubernetes/.git
# rm gravitee-kubernetes/gravitee/requirements.lock
# rm gravitee-kubernetes/gravitee/requirements.yaml
# cp -R gravitee-kubernetes/gravitee ../charts
git clone https://github.com/rowanruseler/helm-charts.git && rm -rf helm-charts/.git
cp -R helm-charts/charts/pgadmin4 ../charts

wget https://github.com/jetstack/cert-manager/archive/release-0.14.zip
unzip release-0.14.zip
rm release-0.14.zip
cp -R cert-manager-release-0.14/deploy/charts/cert-manager ../charts

wget https://github.com/nginxinc/kubernetes-ingress/archive/v1.6.3.zip
unzip v1.6.3.zip
rm v1.6.3.zip
cp kubernetes-ingress-1.6.3/LICENSE ../charts/kubernetes-ingress
cp -R kubernetes-ingress-1.6.3/deployments/helm-chart/* ../charts/nginx-ingress/

cd ..
rm -rf tmp