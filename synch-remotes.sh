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
cd ..
rm -rf tmp