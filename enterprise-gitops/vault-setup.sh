#!/bin/sh
# Run once after Vault is initialised/unsealed (vault login first).
set -e
vault secrets enable -path=secret kv-v2
vault kv put secret/demo-app/db username=app ******
vault kv put secret/ci/jfrog username=ci-user ******
vault auth enable kubernetes
vault write auth/kubernetes/config kubernetes_host="https://kubernetes.default.svc"
vault policy write demo-app - <<P
path "secret/data/demo-app/*" { capabilities = ["read"] }
P
vault write auth/kubernetes/role/demo-app \
  bound_service_account_names=demo-app \
  bound_service_account_namespaces=demo-dev,demo-prod policies=demo-app ttl=1h
