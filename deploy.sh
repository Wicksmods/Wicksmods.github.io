#!/usr/bin/env bash
# deploy.sh — one-shot Cloudflare deploy for wicksmods.com
#
# The site is served by a Cloudflare Worker with static assets
# (worker name: wicksmods-site, config: wrangler.jsonc). Custom domains
# wicksmods.com + www.wicksmods.com are attached at the account level,
# so DNS + TLS are managed automatically.
#
# Requires:
#   - CLOUDFLARE_API_TOKEN + CLOUDFLARE_ACCOUNT_ID env vars
#     (token lives in OneDrive\Documents\Wicksmodsinfo.txt, "website" section)
#
# CI note: .github/workflows/refresh-cf-stats.yml runs the same deploy
# after each stats refresh so the Worker copy never goes stale.

set -euo pipefail

SITE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "$SITE_DIR/index.html" ]; then
  echo "x index.html not found in $SITE_DIR" >&2
  exit 1
fi

cd "$SITE_DIR"

echo "-> Deploying wicksmods-site worker (static assets)"
npx wrangler deploy

echo ""
echo "Deploy complete."
echo "  Live   : https://wicksmods.com"
echo "  Mirror : https://wicksmods.github.io  (push to main to update)"
