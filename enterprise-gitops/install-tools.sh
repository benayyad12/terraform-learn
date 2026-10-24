#!/bin/sh
# Installs ArgoCD, Vault, SonarQube and Artifactory on the current kube context.
set -e
helm repo add argo https://argoproj.github.io/argo-helm
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
helm repo add jfrog https://charts.jfrog.io
helm repo update
helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace
helm upgrade --install vault hashicorp/vault -n vault --create-namespace --set injector.enabled=true
helm upgrade --install sonarqube sonarqube/sonarqube -n sonarqube --create-namespace --set community.enabled=true
helm upgrade --install artifactory jfrog/artifactory -n jfrog --create-namespace
