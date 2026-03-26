# dotfiles

Automated setup scripts and shell configuration for macOS development environment (AI/MLOps, Kubernetes, Terraform, Docker).

## Scripts

| Script | Purpose |
|--------|---------|
| `brew.sh` | Install Homebrew, CLI tools (uv, kubectl, helm, terraform, gh, awscli, azure-cli), Docker cask, VS Code + extensions, Oh My Zsh |
| `git.sh` | Configure git (pre-commit, SSH keys, GPG signing, tags, signed commits) |
| `docker.sh` | Pull and tag Python 3.13-slim image, run pytest container |
| `helm.sh` | Install/upgrade helm charts: KEDA, Ingress-Nginx, Apache Airflow with environment variables |
| `kubectl.sh` | Apply/manage k8s resources, port-forward, Istio verify, query ingress hosts/ports |
| `terraform.sh` | Initialize, validate, plan, apply Terraform with environment prompts (dev/int/prd) |
| `.zshrc` | Shell config: aliases (tf, k, aws, az), venv setup, completions, kube-ps1 prompt |

## Quick Start

```bash
# Full setup
bash brew.sh

# Individual tools (after brew.sh)
bash git.sh      # Configure git + SSH + GPG
bash docker.sh   # Pull python:3.13-slim
bash terraform.sh dev  # Or: ./terraform.sh (interactive prompt)
bash helm.sh     # Deploy KEDA, Airflow
bash kubectl.sh  # k8s cluster ops
```

## Features

- **Error handling**: All scripts use `set -e` (fail-fast)
- **Idempotent**: Safe to re-run; checks before installing/appending
- **Environment support**: Terraform script supports dev/int/prd with automatic workspace switching
- **Non-interactive mode**: terraform.sh accepts positional arg: `./terraform.sh prod`
- **Aliases**: 45+ aliases for git, k8s, terraform in `.zshrc`

## Platform

macOS only (uses Homebrew, pinentry-mac, `.zshrc`)

## Requirements

- macOS 10.14+
- Git
- curl

## Notes

- Set placeholder values in `git.sh`: EMAIL, USERNAME
- Update `kubectl.sh` SVC_NAME, NAMESPACE for your cluster
- Review `helm.sh` chart versions before deploying
- Terraform destroy command commented out for safety; uncomment in `terraform.sh` if needed