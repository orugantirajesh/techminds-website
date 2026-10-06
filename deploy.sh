#!/usr/bin/env bash
# Deploy the TechMinds site to the live Hostinger VPS (rajeshoruganti.tech).
# Syncs local files to the server; nginx serves them directly, no restart needed.
set -euo pipefail
cd "$(dirname "$0")"

VPS_HOST="root@72.60.192.209"
VPS_KEY="$HOME/.ssh/id_ed25519_hostinger"
REMOTE_DIR="/docker/techminds/site/"

echo "→ Deploying to $VPS_HOST:$REMOTE_DIR"

rsync -av -e "ssh -i $VPS_KEY" \
  --exclude='.git' \
  --exclude='.gitignore' \
  --exclude='DEPLOY.md' \
  --exclude='deploy.sh' \
  --exclude='serve.sh' \
  --exclude='.DS_Store' \
  --exclude='assets/logo-original.png' \
  ./ "$VPS_HOST:$REMOTE_DIR"

echo "→ Done. Live at https://rajeshoruganti.tech"
