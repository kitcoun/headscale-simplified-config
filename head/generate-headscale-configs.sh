#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f ../.env ]; then
  echo "error: ../.env not found"
  exit 1
fi

set -a
. ../.env
set +a

envsubst '${DHE_TAILSCALE_HOST} ${DHE_TAILNET_DOMAIN}' < headplane-config/config.yaml.tpl > headplane-config/config.yaml
envsubst '${DHE_TAILSCALE_HOST} ${DHE_TAILNET_DOMAIN}' < headscale-config/config.yaml.tpl > headscale-config/config.yaml
envsubst '${DHE_DERP_HOST}' < headscale-config/derp.yaml.tpl > headscale-config/derp.yaml

echo "Generated headplane-config/config.yaml, headscale-config/config.yaml, headscale-config/derp.yaml"
