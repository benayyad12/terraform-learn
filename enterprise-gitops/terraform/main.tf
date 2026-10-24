terraform {
  required_providers {
    helm = { source = "hashicorp/helm", version = "~> 2.12" }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig
  }
}

variable "kubeconfig" {
  type    = string
  default = "~/.kube/config"
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
}

resource "helm_release" "vault" {
  name             = "vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  namespace        = "vault"
  create_namespace = true
  set {
    name  = "injector.enabled"
    value = "true"
  }
}

resource "helm_release" "sonarqube" {
  name             = "sonarqube"
  repository       = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart            = "sonarqube"
  namespace        = "sonarqube"
  create_namespace = true
  set {
    name  = "community.enabled"
    value = "true"
  }
}

resource "helm_release" "artifactory" {
  name             = "artifactory"
  repository       = "https://charts.jfrog.io"
  chart            = "artifactory"
  namespace        = "jfrog"
  create_namespace = true
}
