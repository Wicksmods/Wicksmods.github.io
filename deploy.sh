#!/usr/bin/env bash
# deploy.sh — one-shot Cloudflare Pages deploy for wicksmods.io
#
# Requires:
#   - wrangler CLI installed   (npm install -g wrangler)
#   - Authenticated: either `wrangler login` (one-time OAuth) or
#     `CLOUDFLARE_API_TOKEN` env var with Pages:Edit scope.
#
# What it does:
#   1. Validates the working directory has index.html.
#   2. Pushes the current folder to Cloudflare Pages project "wicksmods".
#   3. Prints the deployment URL.

set -euo pipefail

PROJECT_NAME="wicksmods"
SITE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "$SITE_DIR/index.html" ]; then
  echo "✗ index.html not found in $SITE_DIR" >&2
  exit 1
fi

if ! command -v wrangler >/dev/null 2>&1; then
  echo "✗ wrangler not installed. Run: npm install -g wrangler" >&2
  exit 1
fi

cd "$SITE_DIR"

echo "→ Deploying to Cloudflare Pages project: $PROJECT_NAME"
wrangler pages deploy . --project-name="$PROJECT_NAME" --branch=main --commit-dirty=true

echo ""
echo "✓ Deploy complete."
echo "  Preview : https://${PROJECT_NAME}.pages.dev"
echo "  Live    : https://wicksmods.io  (once DNS is wired up)"
