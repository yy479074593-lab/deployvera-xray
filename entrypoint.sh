#!/bin/sh
# DeployVera supplies $PORT. UUID and WS_PATH are DeployVera env vars
# set in the panel — they are NOT baked into the repo.
set -e
PORT="${PORT:-8080}"
: "${UUID:?UUID env var is required}"
: "${WS_PATH:?WS_PATH env var is required}"
sed -e "s/__PORT__/$PORT/" -e "s/__UUID__/$UUID/" -e "s#__WS_PATH__#$WS_PATH#" \
  /config.template.json > /usr/local/etc/xray/config.json
exec /usr/local/bin/xray run -config /usr/local/etc/xray/config.json
