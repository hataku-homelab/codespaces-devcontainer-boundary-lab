#!/usr/bin/env bash
set -euo pipefail

echo "DEVCONTAINER_POSTSTART_JUPYTER_FAST_MARKER_20260706"

REPO_DIR="/workspaces/codespaces-devcontainer-boundary-lab"
cd "$REPO_DIR"

mkdir -p reports

{
  echo "POSTSTART_RUNTIME_FAST_MARKER_20260706"
  date -u
  whoami || true
  pwd || true
  env | sort | grep -E 'JUPYTER|CODESPACE|GITHUB' || true
  which jupyter || true
  jupyter --version || true
} > reports/poststart-runtime.txt
