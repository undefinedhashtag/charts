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

wget https://github.com/helm/charts/archive/cfcf87ac254dcbb2d4aa1c866e20dd7e8e55b8e5.zip
unzip cfcf87ac254dcbb2d4aa1c866e20dd7e8e55b8e5.zip
rm cfcf87ac254dcbb2d4aa1c866e20dd7e8e55b8e5.zip
cp charts-cfcf87ac254dcbb2d4aa1c866e20dd7e8e55b8e5/LICENSE ../charts/nginx-ingress/
cp -R charts-cfcf87ac254dcbb2d4aa1c866e20dd7e8e55b8e5/stable/nginx-ingress ../charts/

cd ..
rm -rf tmp