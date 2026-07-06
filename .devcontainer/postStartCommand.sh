#!/usr/bin/env bash
set -euo pipefail

echo "DEVCONTAINER_POSTSTART_JUPYTER_BOUNDARY_MARKER_20260706"

cd /workspaces/codespaces-devcontainer-boundary-lab

mkdir -p reports

{
  echo "POSTSTART_RUNTIME_MARKER_20260706"
  date -u
  whoami
  pwd
  env | sort | grep -E 'JUPYTER|CODESPACE|GITHUB' || true
} > reports/poststart-runtime.txt
