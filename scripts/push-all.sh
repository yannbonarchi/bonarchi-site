#!/usr/bin/env sh
# Push the current branch to BOTH GitHub remotes.
#
#   origin       -> github.com/bonarchisimeu/bonarchi-site   (your primary)
#   yannbonarchi -> github.com/yannbonarchi/bonarchi-site     (Cloudflare deploys from here)
#
# The two repos live under separate GitHub accounts, so a single token cannot
# push to both. We switch the active `gh` account between pushes and restore
# bonarchisimeu as the active account on exit.
#
# Usage:  git pushboth        (alias, configured once)
#    or:   sh scripts/push-all.sh
set -e

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
restore() { gh auth switch --user bonarchisimeu >/dev/null 2>&1 || true; }
trap restore EXIT

echo "→ origin (bonarchisimeu): $BRANCH"
gh auth switch --user bonarchisimeu >/dev/null 2>&1 || true
git push origin "$BRANCH"

echo "→ yannbonarchi (Cloudflare source): $BRANCH"
gh auth switch --user yannbonarchi >/dev/null 2>&1 || true
git push yannbonarchi "$BRANCH"

echo "✓ pushed $BRANCH to both remotes"
