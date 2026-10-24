# Enterprise GitOps example

Flow: **dev push → GitHub Actions → SonarQube (quality gate) → build image → push to JFrog Artifactory → CI commits new tag to `k8s/overlays/dev` → ArgoCD syncs to Kubernetes**. **Vault** stores secrets (JFrog creds for CI via JWT auth; app secrets injected into pods by Vault Agent).

| Path | Purpose |
|---|---|
| `app/` | Sample app + Dockerfile |
| `k8s/` | Kustomize base + dev/prod overlays (GitOps source of truth) |
| `argocd/` | ArgoCD Applications (dev auto-sync, prod) |
| `terraform/` | Installs ArgoCD, Vault, SonarQube, Artifactory via Helm |
| `.github/workflows/ci.yaml` | Pipeline (copy to repo root `.github/workflows/`) |
| `vault-setup.sh` | Vault KV, Kubernetes auth, policies |

## Steps
1. `cd terraform && terraform init && terraform apply`
2. Init/unseal Vault, then run `./vault-setup.sh`
3. Create `jfrog-regcred` pull secret in `demo-dev`/`demo-prod`
4. Set repo secrets `SONAR_TOKEN`, `SONAR_HOST_URL`, `VAULT_ADDR`; configure Vault JWT auth role `ci`
5. `kubectl apply -f argocd/`
6. Push a change under `app/` and watch ArgoCD deploy.

Promote to prod by copying the tag into `k8s/overlays/prod` via PR.
