#!/usr/bin/env bash
set -euo pipefail

mkdir -p reports

{
  echo "DEVCONTAINER_POSTSTART_MARKER_20260706"
  echo "timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
} | tee reports/postStart-evidence.txt

# Run a harmless HTTP server on 3000 if not already running.
if ! pgrep -f "python3 -m http.server 3000" >/dev/null 2>&1; then
  nohup bash -lc 'cd reports && python3 -m http.server 3000' > reports/http-server.log 2>&1 &
fi

# Run a second harmless server on 8888 to exercise Jupyter-like port naming without real Jupyter.
if ! pgrep -f "python3 -m http.server 8888" >/dev/null 2>&1; then
  nohup bash -lc 'cd reports && python3 -m http.server 8888' > reports/http-server-8888.log 2>&1 &
fi
