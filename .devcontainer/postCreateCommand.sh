#!/usr/bin/env bash
set -euo pipefail

mkdir -p reports

{
  echo "DEVCONTAINER_POSTCREATE_MARKER_20260706"
  echo "timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "whoami=$(whoami)"
  echo "pwd=$(pwd)"
  echo "hostname=$(hostname)"
  echo "--- selected env var names only ---"
  env | cut -d= -f1 | sort | grep -E 'GITHUB|CODESPACE|VSCODE|TOKEN|SECRET|SSH|GH' || true
  echo "--- terminal escape marker display test ---"
  printf 'TERMINAL_ESCAPE_MARKER_20260706\n'
  printf '\033]0;CODESPACE_TITLE_MARKER_20260706\007\n'
  printf '\033[31mCOLOR_MARKER_20260706\033[0m\n'
} | tee reports/postCreate-evidence.txt

# Start a harmless web server for forwarded-port/label tests.
cat > reports/index.html <<'HTML'
<!doctype html>
<html>
  <head><title>Codespaces Boundary Lab</title></head>
  <body>
    <h1>PORT_SERVER_MARKER_20260706</h1>
    <p>This is a harmless local Codespaces port-forwarding test page.</p>
  </body>
</html>
HTML
