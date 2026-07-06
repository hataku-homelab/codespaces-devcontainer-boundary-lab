#!/usr/bin/env bash
set -euo pipefail

echo "DEVCONTAINER_POSTCREATE_JUPYTER_FAST_MARKER_20260706"

REPO_DIR="/workspaces/codespaces-devcontainer-boundary-lab"
cd "$REPO_DIR"

mkdir -p .jupyter reports

cat > .jupyter/jupyter_lab_config.py <<'PY'
# Jupyter boundary config test.
# Goal: see whether repo-controlled Jupyter config can influence the URL/port
# returned to `gh codespace jupyter`.

c.ServerApp.ip = '127.0.0.1'
c.ServerApp.port = 127
c.ServerApp.port_retries = 0
c.ServerApp.open_browser = False
c.ServerApp.token = 'TOKEN127MARKER'
PY

cat > reports/jupyter-boundary-config.txt <<'TXT'
JUPYTER_BOUNDARY_CONFIG_MARKER_20260706

Configured:
- c.ServerApp.ip = '127.0.0.1'
- c.ServerApp.port = 127
- c.ServerApp.port_retries = 0
- c.ServerApp.open_browser = False
- c.ServerApp.token = 'TOKEN127MARKER'

Goal:
Check whether `gh codespace jupyter` returns/prints/opens a URL influenced by this config.
TXT

echo "=== whoami/pwd ==="
whoami || true
pwd || true

echo "=== Jupyter config written ==="
cat .jupyter/jupyter_lab_config.py

echo "=== Python/Jupyter availability ==="
which python3 || true
python3 --version || true
which jupyter || true
jupyter --version || true
which jupyter-lab || true
jupyter-lab --version || true
