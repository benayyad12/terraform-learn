# Enterprise GitOps example

Flow: **dev push → GitHub Actions → SonarQube (quality gate) → build image → push to JFrog Artifactory → CI commits new tag to `k8s/overlays/dev` → ArgoCD syncs to Kubernetes**. **Vault** stores secrets (JFrog creds for CI via JWT auth; app secrets injected into pods by Vault Agent).

| Path | Purpose |
|---|---|
| `app/` | Sample app + Dockerfile |
| `k8s/` | Kustomize base + dev/int/uat/prod overlays (GitOps source of truth) |
| `argocd/` | ArgoCD Applications (one per environment) |
| `platform/` | Kustomize for ArgoCD and SonarQube (no Helm) |
| `.github/workflows/ci.yaml` | Pipeline (copy to repo root `.github/workflows/`) |
| `vault-setup.sh` | Vault KV, Kubernetes auth, policies |

## Steps
1. `kubectl apply -k platform/argocd && kubectl apply -k platform/sonarqube`. JFrog Artifactory (`mycompany.jfrog.io`) and Vault (with the Agent Injector and Kubernetes auth enabled) are assumed to be provided by the platform team / SaaS.
2. Init/unseal Vault, then run `./vault-setup.sh`
3. Create `jfrog-regcred` pull secret in every `demo-*` namespace
4. Set repo secrets `SONAR_TOKEN`, `SONAR_HOST_URL`, `VAULT_ADDR`; configure Vault JWT auth role `ci`
5. `kubectl apply -f argocd/`
6. Push a change under `app/` and watch ArgoCD deploy.

Promotion: CI deploys to `dev`; promote the same image tag through `int` → `uat` → `prod` by PR editing `k8s/overlays/<env>/kustomization.yaml`. Each env has its own namespace (`demo-<env>`) and ArgoCD Application.

No Helm and no Terraform: everything is plain YAML + Kustomize (`k8s/base` + `k8s/overlays/<env>`).
