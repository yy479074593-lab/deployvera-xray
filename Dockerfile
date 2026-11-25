# Xray VLESS+WS on DeployVera Container Free — same recipe as Cloady / Render.
# TLS is terminated by DeployVera's edge (443 -> $PORT, plain HTTP/WS inside).
# DeployVera builds the image from a Git repo (Public / GitHub / GitLab),
# Dockerfile or Nixpacks auto-build. No direct public Docker image deploy.
FROM ghcr.io/xtls/xray-core:latest AS xray
FROM alpine:3.22
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY --from=xray /usr/local/share/xray/ /usr/local/share/xray/
COPY entrypoint.sh /entrypoint.sh
COPY config.template.json /config.template.json
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
