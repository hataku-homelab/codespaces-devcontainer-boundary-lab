#!/usr/bin/env bash
set -euo pipefail

mkdir -p reports

OUT="reports/codespace-runtime-evidence.txt"

{
  echo "# Codespace Runtime Evidence"
  echo "timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "whoami=$(whoami)"
  echo "pwd=$(pwd)"
  echo "hostname=$(hostname)"
  echo
  echo "## Markers"
  grep -R "MARKER_20260706" .devcontainer reports scripts README.md 2>/dev/null || true
  echo
  echo "## Processes"
  ps aux | grep -E 'http.server|jupyter|node|code|vscode' | grep -v grep || true
  echo
  echo "## Listening ports"
  (ss -ltnp || netstat -ltnp) 2>/dev/null || true
  echo
  echo "## Selected env var names only"
  env | cut -d= -f1 | sort | grep -E 'GITHUB|CODESPACE|VSCODE|TOKEN|SECRET|SSH|GH' || true
  echo
  echo "## Token-looking values search in repo files"
  grep -RInE 'gh[upsr]_[A-Za-z0-9_]{20,}' . --exclude-dir=.git || true
} | tee "$OUT"
