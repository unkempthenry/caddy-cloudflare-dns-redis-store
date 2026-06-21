FROM caddy:2-builder AS builder

ARG CADDY_VERSION

RUN xcaddy build ${CADDY_VERSION:+${CADDY_VERSION}} \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/pberkel/caddy-storage-redis
    # --with github.com/greenpau/caddy-security

FROM caddy:2-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
