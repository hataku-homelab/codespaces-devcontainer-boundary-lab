#!/usr/bin/env bash
set -euxo pipefail

echo "DEVCONTAINER_SYSCTL127_SETUP_START"

# GitHub default/universal image already includes JupyterLab, but keep checks explicit.
which python3 || true
python3 --version || true
which jupyter-lab || true
jupyter-lab --version || true

sudo sysctl -w net.ipv4.ip_unprivileged_port_start=0
sysctl net.ipv4.ip_unprivileged_port_start

mkdir -p /home/codespace/.jupyter

cat > /home/codespace/.jupyter/jupyter_lab_config.py <<'PY'
c.ServerApp.ip = "127.0.0.1"
c.ServerApp.port = 127
c.ServerApp.port_retries = 0
c.ServerApp.open_browser = False
c.ServerApp.token = "DEVCONTAINER_SYSCTL127_MARKER"
PY

cat /home/codespace/.jupyter/jupyter_lab_config.py

echo "DEVCONTAINER_SYSCTL127_SETUP_DONE"
