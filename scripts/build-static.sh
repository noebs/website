#!/bin/sh
set -eu

cd "$(dirname "$0")/.."

# The locked sharp/webpack toolchain requires Node 12. Run only the static
# generator with that version; Wrangler runs separately with current Node.
npm exec --yes --package=node@12.22.12 --package=npm@6.14.16 -- npm ci --production=false --no-audit --no-fund
npm exec --yes --package=node@12.22.12 --package=npm@6.14.16 -- npm run build
