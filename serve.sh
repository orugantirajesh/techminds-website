#!/usr/bin/env bash
# Serve the TechMinds static site locally.
set -euo pipefail
cd "$(dirname "$0")"
PORT="${PORT:-8080}"
echo "→ http://127.0.0.1:${PORT}"
exec python3 -m http.server "$PORT" --bind 127.0.0.1
